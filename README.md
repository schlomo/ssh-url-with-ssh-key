# ssh-url-with-ssh-key SSH wrapper

See also http://blog.schlomo.schapiro.org/2017/05/embedding-ssh-key-in-ssh-url.html

ssh-url-with-ssh-key is a wrapper for ssh that extracts a base64 encoded SSH key
from the SSH `user`**~key**`@host` URL and launches SSH with that key.

Set the `GIT_SSH` environment variable to this script (ssh-url-with-ssh-key)
to activate it for your git usage.

## Usage
```
ssh-url-with-ssh-key [--help | --create | user~key@host] [command]

--create    Create a new private and public SSH key. This will print
            out the private key as you should append it to the SSH
            user and the public key to add to a remote system.
```

## Examples
```
# clone GitHub repo with Deploy Keys
$ GIT_SSH=ssh-url-with-ssh-key git clone git~LS0tLS1CRUdJTiBP....SDFWENF324DS=@github.com:user/repo.git

# connect to remote SSH server
$ ssh-url-with-ssh-key user~LS0tLS1CRUdJTiBP....SDFWENF324DS=@host

# create new SSH key pair
$ ./ssh-url-with-ssh-key --create schlomo test
Append this base64-encoded private key to the username:
~LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUFTZUVqcDRJcFVubGhkTDVEU0VuVkc2aVM0U21Qd3NWR1hNVDhFbDFVZlBvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFbHNRYnZaKzhMLzR3enhYMDlEdGZnZGFTaDVzSFpHUHVUcnVtWXd0UW4yb0txMFVNRmZjaQo4bWFqWWRqclF1YU8vdGN6aCtOWjJ3ZVZiZmY3WE5kQ01RPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
Public Key:
ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBJbEG72fvC/+MM8V9PQ7X4HWkoebB2Rj7k67pmMLUJ9qCqtFDBX3IvJmo2HY60Lmjv7XM4fjWdsHlW33+1zXQjE= schlomo test

```
Written to support [GitHub Deploy Keys](https://developer.github.com/guides/managing-deploy-keys/#deploy-keys) with tools that cannot manage
per-repository SSH keys but only offer to store a GitHub URL.

## Docker

https://hub.docker.com/r/schlomo/ssh-url-with-ssh-key/ is an [Alpine](https://hub.docker.com/_/alpine/) based Docker image with `ssh-url-with-ssh-key` and `git`, `rsync` and `ssh` included so that you can simply try it out or use it without installation:

```
$ docker run -it --rm schlomo/ssh-url-with-ssh-key ssh-url-with-ssh-key --create run in docker
Append this base64-encoded private key to the username:
~LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSVB4S1Fzak9wQ2lTSHVSWkVucWFXYnJUT2hqdW9RSWdtYlRJVzQ2clM4MklvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFZzJ0eEFGVHRBalFSOHpia2g3S1U4Rldpd2NLdXkrNWpRWGVHZ1QrcUZIMk1zOWFBU1M5aAplY3o2UGtyeFZ0ZzdjSTYzV3VKekxjdmduUHBPMUhPOWZRPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=
Public Key:
ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBINrcQBU7QI0EfM25IeylPBVosHCrsvuY0F3hoE/qhR9jLPWgEkvYXnM+j5K8VbYO3COt1ricy3L4Jz6TtRzvX0= run in docker
```

You can also use it to clone a git repo, for example like this:
```
$ docker run -it --rm -v $(pwd):/work schlomo/ssh-url-with-ssh-key git clone --depth 1 git~LS0tLS1CRUdJTiBFQyBQUklWQVRFIEtFWS0tLS0tCk1IY0NBUUVFSUZqWlhTQjBNVDlwNzNoQzJSUXFKU3F6TkZENmkrQ2dabTVvNzE0MGRYZHZvQW9HQ0NxR1NNNDkKQXdFSG9VUURRZ0FFMG93bkY4SDVXRHcrVXJoQVZpSnZucGFvMEpzRzlCZW5QK1lCL0hBSWd4dm5ubFUyRytEawpmcDhoUWZoa2Z2YXowMk9YbU1JWWJYVENCVkhTSmoxbUlnPT0KLS0tLS1FTkQgRUMgUFJJVkFURSBLRVktLS0tLQo=@github.com:schlomo/demo-data.git foo
Cloning into 'foo'...
The authenticity of host 'github.com (192.30.253.112)' can't be established.
RSA key fingerprint is SHA256:nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,192.30.253.112' (RSA) to the list of known hosts.
remote: Counting objects: 3, done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 3 (delta 0), pack-reused 0
Receiving objects: 100% (3/3), done.
$ cd foo
$ git status
On branch master
Your branch is up to date with 'origin/master'.

nothing to commit, working tree clean
```

See [Using Kubernetes with Multiple Containers for Initialization and Maintenance](http://blog.schlomo.schapiro.org/2017/06/using-kubernetes-with-multiple.html) for a working example of using this Docker image.

