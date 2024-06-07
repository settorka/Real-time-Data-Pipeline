package main

import (
    "encoding/json"
    "fmt"
    "math/rand"
    "net/http"
    "os"
    "os/signal"
    "sync"
    "syscall"
    "time"

    "github.com/confluentinc/confluent-kafka-go/kafka"
)

var (
    rate      = 3
    rateLock  sync.RWMutex
    running   = false
    startStop = make(chan bool)
)

type Record struct {
    APIName     string    `json:"apiName"`
    RandomText  string    `json:"randomText"`
    CurrentTime time.Time `json:"currentTime"`
}

func main() {
    producer, err := kafka.NewProducer(&kafka.ConfigMap{"bootstrap.servers": "kafka:9092"})
    if err != nil {
        panic(err)
    }
    defer producer.Close()

    go handleHTTPRequests()

    go func() {
        for start := range startStop {
            if start {
                startDataGeneration(producer)
            } else {
                stopDataGeneration()
            }
        }
    }()

    // Wait for termination signal
    sigchan := make(chan os.Signal, 1)
    signal.Notify(sigchan, syscall.SIGINT, syscall.SIGTERM)
    <-sigchan
}

func handleHTTPRequests() {
    http.HandleFunc("/set-rate", func(w http.ResponseWriter, r *http.Request) {
        if r.Method != http.MethodPost {
            http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
            return
        }

        var data struct {
            Rate int `json:"rate"`
        }

        if err := json.NewDecoder(r.Body).Decode(&data); err != nil {
            http.Error(w, "Invalid request body", http.StatusBadRequest)
            return
        }

        rateLock.Lock()
        rate = data.Rate
        rateLock.Unlock()

        fmt.Fprintf(w, "Rate set to %d\n", data.Rate)
    })

    http.HandleFunc("/start", func(w http.ResponseWriter, r *http.Request) {
        if r.Method != http.MethodPost {
            http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
            return
        }

        rateLock.Lock()
        running = true
        rateLock.Unlock()

        startStop <- true
        fmt.Fprintln(w, "Data generation started")
    })

    http.HandleFunc("/stop", func(w http.ResponseWriter, r *http.Request) {
        if r.Method != http.MethodPost {
            http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
            return
        }

        rateLock.Lock()
        running = false
        rateLock.Unlock()

        startStop <- false
        fmt.Fprintln(w, "Data generation stopped")
    })

    http.ListenAndServe(":8080", nil)
}

func startDataGeneration(producer *kafka.Producer) {
    go func() {
        for {
            rateLock.RLock()
            currentRate := rate
            isRunning := running
            rateLock.RUnlock()

            if !isRunning {
                break
            }

            var wg sync.WaitGroup
            for i := 0; i < currentRate; i++ {
                wg.Add(1)
                go func() {
                    defer wg.Done()
                    produceRecord(producer)
                }()
            }
            wg.Wait()
            time.Sleep(1 * time.Second)
        }
    }()
}

func stopDataGeneration() {
    // Close the startStop channel to stop the goroutine
    close(startStop)
}

func produceRecord(producer *kafka.Producer) {
    record := Record{
        APIName:     getRandomAPIName(),
        RandomText:  getRandomString(10),
        CurrentTime: time.Now(),
    }

    recordBytes, err := json.Marshal(record)
    if err != nil {
        fmt.Println("Error marshaling record:", err)
        return
    }

    topic := getRandomAPIName()
    err = producer.Produce(&kafka.Message{
        TopicPartition: kafka.TopicPartition{Topic: &topic, Partition: kafka.PartitionAny},
        Value:          recordBytes,
    }, nil)

    if err != nil {
        fmt.Println("Error producing record:", err)
    }
}

func getRandomAPIName() string {
    apis := []string{"nodejs", "rails", "phoenix", "django", "springboot", "aspnetcore"}
    return apis[rand.Intn(len(apis))]
}

func getRandomString(length int) string {
    letters := []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    s := make([]rune, length)
    for i := range s {
        s[i] = letters[rand.Intn(len(letters))]
    }
    return string(s)
}
