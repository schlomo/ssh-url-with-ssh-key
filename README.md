# ssh-url-with-ssh-key SSH wrapper

ssh-url-with-ssh-key is a wrapper for ssh that extracts a base64 encoded SSH key
from the SSH `user`**~key**`@host` URL and launches SSH with that key.

Set the `GIT_SSH` environment variable to this script (ssh-url-with-ssh-key)
to activate it for your git usage.

**Usage:**
```
ssh-url-with-ssh-key [--help | --create | user~key@host] [command]

--create    Create a new private and public SSH key. This will print
            out the private key as you should append it to the SSH
            user and the public key to add to a remote system.
```

**Example usage:**
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
