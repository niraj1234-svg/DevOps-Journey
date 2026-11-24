const express = require("express");
const fs = require("fs");

const app = express();
const PORT = 80;
const DATA_DIR = "/app/data";

if (!fs.existsSync(DATA_DIR)) {
    fs.mkdirSync(DATA_DIR, { recursive: true });
}

app.get("/", (req, res) => {
    res.send("Hello, Docker! Application is running.");
});

app.get("/save", (req, res) => {
    const message = "Docker Volume Persistence Working!";
    fs.writeFileSync(`${DATA_DIR}/message.txt`, message);
    res.send("Data saved successfully!");
});

app.get("/read", (req, res) => {
    const file = `${DATA_DIR}/message.txt`;

    if (!fs.existsSync(file)) {
        return res.status(404).send("No saved data found.");
    }

    res.send(fs.readFileSync(file, "utf8"));
});

app.listen(PORT, "0.0.0.0", () => {
    console.log(`Server running on port ${PORT}`);
});
