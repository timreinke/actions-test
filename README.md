# actions-test

Small-ish demo of signal handling bug. `parallel_test` can sometimes send 
SIGINT to the child process in addition to the signal triggered by ctrl+c
in a tty.

```
$ bundle exec rake demo
ruby exercise_pty.rb --quiet
interrupt_count: 2


ruby exercise_pty.rb --quiet --no-rake
interrupt_count: 1
```

With strace via docker:
```
docker build -t actions-test .
docker run actions-test
```

or directly
```
strace -f -e 'trace=!all' bundle exec rake demo
```

You can observe the test process get SIGINT from both the kernel and 
parallel_test process.