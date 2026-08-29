# Ring Quest

**Learn Docker the Middle-earth way.**

Could learning Docker be fun?  
This project answers that question with a yes.

Ring Quest is an interactive, console-based adventure that teaches the fundamentals of Docker through the early journey of Frodo and the Fellowship — from the Shire to Rivendell.

You will run a Docker-in-Docker environment and complete practical challenges while the story unfolds around you.

---

## What You Will Learn

- Difference between images and containers
- Listing and inspecting containers
- Accessing containers with `docker exec`
- Running containers from existing images
- Writing basic Dockerfiles and building images

---

## Requirements

- Docker installed and running
- A terminal with **at least 150 columns** (important for the visuals)
- ~650 MB of disk space for the image
- Works on Linux and Windows (tested)

---

## How to Play

```bash
# 1. Clone the repository
git clone https://github.com/lmayala/ring-quest.git
cd ring-quest

# 2. Build the image
docker build -t ring-quest .

# 3. Run the container (privileged mode is required)
docker run -d --name ring-quest --privileged ring-quest

# 4. Enter the adventure
docker exec -it ring-quest /bin/bash
```

Once inside, the game will guide you.

---

## The Story

You follow Frodo and the hobbits as they flee the Shire, pursued by the Nazgûl.  
Your goal is to reach the Prancing Pony and continue toward Rivendell, solving Docker challenges at each stage.

---

## Series

This is **Part 1** of a learning path:

1. **Ring Quest** → Docker fundamentals  
2. [Tower Quest](https://github.com/lmayala/tower-quest) → Docker Compose  
3. *(Coming soon)* Return of the King → Kubernetes

---

## Disclaimer

This is a non-commercial fan project created purely for educational purposes.  
It is not affiliated with or endorsed by the Tolkien Estate or any film studios.  
Please support the official works of J.R.R. Tolkien.

---

## Contributing & Feedback

Issues, suggestions, and improvements are welcome!
