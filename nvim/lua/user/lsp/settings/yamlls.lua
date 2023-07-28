return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = require('schemastore').yaml.schemas()
    },
  }
}
