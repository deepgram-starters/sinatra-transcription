<!--
Edit Framework and/or Language into the title for e.g.
- Deepgram React Web App Starter
- Deepgram PHP Websockets Starter
- Deepgram Node Command-line Starter
-->

# Deepgram Ruby Web App Starter

<!-- Write an intro for this project -->

This sample demonstrates interacting with the Deepgram API from Ruby. It uses the Sinatra framework, with a javascript client built from web components.

## Sign-up to Deepgram

<!-- Please leave this section unchanged, unless providing a UTM. -->

Before you start, it's essential to generate a Deepgram API key to use in this project. [Sign-up now for Deepgram](https://console.deepgram.com/signup).

## Quickstart

<!-- Delete these sections as appropriate. Please include at least a manual one. -->

### Manual

Follow these steps to get started with this starter application.

<!-- Edit as appropriate -->

#### Clone the repository

Go to GitHub and [clone the repository](https://github.com/deepgram-starters/deepgram-ruby-starters).

#### Edit the config file

Copy the code from `.env-sample` and create a new file called `.env`. Paste in the code and enter your API key you generated in the [Deepgram console](https://console.deepgram.com/).

```
port=8080
deepgram_api_key=%api_key%
```

#### Run the application

The `ruby` script will run a web and API server concurrently. Once running, you can [access the application in your browser](http://localhost:8080/).

```bash
ruby server.rb
```
