# RustOxideAutoUpdater
> When using lgsm for running a Rust server this will trigger on an oxide update to shut down the server, update oxide and rust, then reboot.
> If there is no update it runs the lgsm monitor command
> This monitors the latest Oxide version and on a new version release

## Install
Default install location is /opt/RustOxideUpdater/

```shell
$mkdir /opt/RustOxideAutoUpdater
$cd RustOxideAutoUpdater
$git clone https://github.com/zybeon/RustOxideAutoUpdater.git
$npm i webrconjs
```

## Usage
When running a Rust server with Oxide mods you normally need to wait until until Oxide releases their update. This is best when used in a cron job running every 1-10 minutes and is meant to replace the need to run the monitor command as this will run the monitor command if no update is found. PID file checking is used to ensure the script does not execute if a previous process is running. (Not tested thoroughly)

Example cron
```
*/5 * * * * bash /opt/RustOxideAutoUpdater/updatecheck.sh
```
## Example call to webrconjs
node rustrconsend.js COMMAND IP PORT RCONPASS

### Example rcon commands
- say Test  - Posts message to all users (node rustrconsend.js "say Visit our Discord server for perks! discord.gg/xxxxxx" IP PORT RCONPASS)
- restart   - Restarts in 300 seconds with 30 second notices
- quit      - Graceful shutdown of server
- heli.call - Calls patrol helicopter
- kickall   - Kicks all players from server
