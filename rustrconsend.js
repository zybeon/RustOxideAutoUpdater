#!/usr/bin/env node

var WebRcon = require('/opt/RustOxideUpdater/node_modules/webrconjs')
var argv = require('/opt/RustOxideUpdater/node_modules/yargs')

.argv

// parse the arguments
var command = process.argv[2]
var server = process.argv[3]
var port = process.argv[4]
var pass = process.argv[5]

// Create a new client:
var rcon = new WebRcon(server, port)

// Handle events:
rcon.on('connect', function() {
    // commenting this out to keep quiet
    console.log('CONNECTED')
    //console.dir(argv)

    console.log('Sending this: ', command)
    // Run a command once connected:
    rcon.run(command, 0)
    // and disconnect immediately
    rcon.disconnect()
    process.exit()
})
rcon.on('disconnect', function() {
    // commenting this out to keep quiet
    //console.log('DISCONNECTED')
})
rcon.on('message', function(msg) {
    console.log('MESSAGE:', msg)
})
rcon.on('error', function(err) {
    // commenting this out to keep quiet
    console.log('ERROR:', err)
    process.exit()
})

// Connect by providing the server's rcon.password:
rcon.connect(pass)
