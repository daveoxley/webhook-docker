## [Webhook](https://github.com/adnanh/webhook/) docker

A Docker container to setup a webhook. 

Create a directory conf to hold hooks config and scripts.
Create hooks.json in conf directory. For instance.
```json
[
  {
    "id": "test-webhook",
    "execute-command": "/conf/test-webhook.sh",
    "command-working-directory": "/conf",
  }
]
```

Also create a script in the conf directory that you've referenced in hooks.json. 

From within the conf directory run docker mounting the current dir as /conf and mapping port 9000 to the host:

```bash
$ docker run -p 9000:9000 -v `pwd`:/conf -d daveoxley/webhook
```
