return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      schemas = {
        ["https://json.schemastore.org/chart.json"] = "/charts/*",
        ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*"
      },
    },
  }
}
