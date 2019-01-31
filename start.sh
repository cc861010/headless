#/bin/bash
docker run -d --shm-size=256m -p 5901:5901 -p 6901:6901 cc861010/headless
