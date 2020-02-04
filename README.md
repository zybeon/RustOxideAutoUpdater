# RustOxideAutoUpdater
> When using lgsm for running a Rust server this will trigger on an oxide update to shut down the server, update oxide and rust, then reboot.
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
Best if used in a cron job every 1-10 minutes. This replaces the need call the monitor command in lgsm if used this way.
Example cron
```
*/5 * * * * bash /opt/RustOxideAutoUpdater/updatecheck.sh
```
## Example call to webrconjs
node rustrconsend.js COMMAND IP PORT RCONPASS

### Example commands
- say Test  - Posts message to all users
- restart   - Restarts in 300 seconds with 30 second notices
- quit      - Graceful shutdown of server
- heli.call - Calls patrol helicopter
- kickall   - Kicks all players from server
