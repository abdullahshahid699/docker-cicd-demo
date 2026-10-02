#!/bin/bash

set -e

echo "Starting integration tests..."

echo "Test 1: App health check"
curl -f http://localhost:3000/health

echo "Test 2: App functionality"
response=$(curl -s http://localhost:3000/)

if echo "$response" | grep -q "Hello from Docker CI/CD Demo"; then
    echo "App functionality test passed"
else
    echo "App functionality test failed"
    echo "Response: $response"
    exit 1
fi

echo "Test 3: Nginx proxy"
curl -f http://localhost:8080/health

echo "Test 4: Simple load test"

for i in {1..10}; do
    curl -f -s http://localhost:3000/ > /dev/null
done

echo "Load test passed: 10 requests"
echo "All integration tests passed!"
