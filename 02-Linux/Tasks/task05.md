# Task 05 – Process Management & Monitoring

## Objective

- Start a background process.
- Monitor the process using ps, top, and htop.
- Identify the Process ID (PID).
- Terminate the process using kill.
- Verify that the process has stopped.

## 1. Start a Background Process

Command:

    ping google.com > ping_test.log &

Explanation:

- ping google.com: Sends network packets to Google.
- >: Redirects command output to a file.
- ping_test.log: Stores ping output.
- &: Runs the process in the background.

The terminal remains available for executing other commands.

## 2. Find Running Processes Using PS

Command:

    ps aux | grep '[p]ing google.com'

Explanation:

- ps: Displays process information.
- a: Shows processes associated with terminals.
- u: Displays user-oriented information.
- x: Includes processes without a controlling terminal.
- grep: Searches for a matching process.

Example output:

    ubuntu  1931  0.0  0.3  8496  2952 pts/0  S  03:56  0:00 ping google.com

Important information:

- PID: Process ID (1931 in this example).
- USER: User running the process.
- %CPU: CPU utilization.
- %MEM: Memory utilization.
- STAT: Process state.
- COMMAND: Command being executed.

## 3. Find PID Using PGREP

Command:

    pgrep -af 'ping google.com'

Example output:

    1931 ping google.com

Explanation:

- pgrep: Searches for running processes.
- -a: Displays the full command line.
- -f: Matches against the full command line.

## 4. Monitor Processes Using TOP

Command:

    top

Explanation:

- top: Displays real-time system and process information.
- Shows CPU utilization.
- Shows memory utilization.
- Displays running processes.
- Displays process IDs and their resource usage.

Useful key:

    q

Press q to exit top.

Monitor a specific process:

    top -p 1931

Note: Replace 1931 with the actual PID.

## 5. Monitor Processes Using HTOP

Command:

    htop

Explanation:

- htop: Interactive process monitoring tool.
- Displays CPU and memory usage.
- Shows running processes.
- Provides an interactive interface.

If htop is not installed:

    sudo apt update
    sudo apt install htop

Useful keys:

- F3: Search for a process.
- F10: Exit htop.

## 6. Terminate a Process Using KILL

Command:

    kill 1931

Explanation:

- kill: Sends a signal to a process.
- 1931: PID of the process.
- By default, kill sends SIGTERM (15).
- SIGTERM requests the process to terminate gracefully.

If the process does not stop normally:

    kill -9 1931

Explanation:

- -9: Sends SIGKILL.
- SIGKILL forcefully terminates the process.

Note: Use kill -9 only when normal termination fails.

## 7. Verify Process Termination

Command:

    pgrep -af 'ping google.com'

Expected result:

No output should appear if the process has terminated.

You can also verify using:

    ps aux | grep '[p]ing google.com'

If no matching process appears, the process is no longer running.

## 8. Important Commands Summary

| Command | Purpose |
|---|---|
| ping google.com & | Start background process |
| ps aux | Display running processes |
| grep | Search for processes |
| pgrep -af | Find PID and command |
| top | Real-time process monitoring |
| htop | Interactive process monitoring |
| kill PID | Gracefully terminate process |
| kill -9 PID | Forcefully terminate process |

## 9. Completion Checklist

- [x] Started background ping process
- [x] Identified PID using ps
- [x] Identified PID using pgrep
- [x] Monitored system using top
- [ ] Monitored process using htop
- [ ] Terminated process using kill
- [ ] Verified process termination

## 10. Key Learning

- A process is a running instance of a program.
- PID uniquely identifies a running process.
- Background processes allow commands to run without blocking the terminal.
- ps and pgrep help identify processes.
- top and htop help monitor system resources.
- kill sends signals to terminate processes.
- SIGTERM allows graceful termination, while SIGKILL forces termination.
