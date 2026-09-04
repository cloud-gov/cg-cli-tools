# Releasing

Here's how to issue a new release:

1. Create a tag for the new release and push it to GitHub. For instance, if you're
   releasing v1.0.4, do:

   ```shell
   git tag -a v1.0.4
   git push origin v1.0.4
   ```

   When running `git tag`, you'll be prompted for a tag
   message.

1. [Create a release for the tag in GitHub](https://docs.github.com/en/repositories/releasing-projects-on-github/managing-releases-in-a-repository#creating-a-release).
