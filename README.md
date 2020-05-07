# Graphryder plugin for Discourse

This is a plugin designed to install and use [RedisGraph](https://oss.redislabs.com/redisgraph/) with a Discourse instance.

It uses the existing redis installation baked into Discourse into order to construct a graph of relationships between nodes.

Current relationships:

- `(topic)-[:authored_by]->(user)`
- `(topic)-[:tagged_with]->(tag)`
- `(topic)-[:member_of]->(group)`
- `(topic)-[:member_of]->(category)`

- `(post)-[:authored_by]->(user)`
- `(post)-[:content_of]->(topic)`

- `(user)-[:member_of]->(group)`
- `(user)-[:member_of]->(category)`
- `(user)-[:member_of]->(topic)`

Currently, a built binary of the RedisGraph module (version [2.0.11-rc1](https://github.com/RedisGraph/RedisGraph/releases/tag/2.0.11-rc1)) is included with this plugin, and installed on Discourse startup, which allows storing nodes and edges within Redis.

### Usage

(TODO: document functionality given in `app/models/base`)

(TODO: document functionality of `app/concerns/model` concern)

(TODO: document functionality of `app/concerns/relationship` concern)

### API

This plugin also exposes an API to serialize graph data for consumption by various graphing clients. It is designed to produce data in a format similar to that laid out in the [Existing graphryder API](https://github.com/edgeryders/graphryder-api)

(TODO: document endpoints / data format)
