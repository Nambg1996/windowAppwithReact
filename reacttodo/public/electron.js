const electron = require("electron/main");
const app = electron.app;
const BrowserWindow = electron.BrowserWindow;
const path = require("path");
const isDev = require("electron-is-dev");
const { spawn } = require("child_process");

const express = require('express');
//const app = express();
const ip = require('ip');
const { exec } = require('child_process');

const server = express();

// Enable CORS for all requests
server.use((req, res, next) => {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS');
  res.setHeader('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
  next();
});

server.get('/', (req, res) => {
  res.send('Hello, worlds!');
});


server.get('/run', (req, res) => {

const command = 'pio run --environment m5stick-c';
const options = {
  cwd: 'C:/Users/次世代05/Desktop/atom311/masterSlave/slave'
};

exec(command, options, (error, stdout, stderr) => {
  if (error) {
    console.error(`Error executing command: ${error.message}`);
    return;
  }
  console.log(`Command output: ${stdout}`);
  
  res.send(stdout);
  return ;
});

  

});

server.get('/ipconfig', (req, res) => {
  exec('ipconfig', (error, stdout, stderr) => {
    if (error) {
      // Handle any errors
      res.status(500).send(error.message);
      return;
    }
    // Send the output to the client
    res.send(stdout);
  });
});




server.listen(3000, '127.0.0.2', () => {
  console.log('Server listening on port 3000');
});




let mainWindow;

function createWindow() {
  mainWindow = new BrowserWindow({
    width: 1500,
    height: 700,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      enableRemoteModule: true,
    }, 
  });
  mainWindow.setMenu(null);
  mainWindow.loadURL(
    isDev
      ? "http://localhost:3000"
      : `file://${path.join(__dirname, "../build/index.html")}`
  );
  mainWindow.webContents.openDevTools();
  mainWindow.on("closed", () => (mainWindow = null));

  
}

app.on("ready", createWindow);
app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});
app.on("activate", () => {
  if (mainWindow === null) {
    createWindow();
  }
});



