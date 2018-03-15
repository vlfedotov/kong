local bit           = require "bit"


local bor           = bit.bor


local plugins = {
  "jwt",
  "acl",
  "correlation-id",
  "cors",
  "oauth2",
  "tcp-log",
  "udp-log",
  "file-log",
  "http-log",
  "key-auth",
  "hmac-auth",
  "basic-auth",
  "ip-restriction",
  "request-transformer",
  "response-transformer",
  "request-size-limiting",
  "rate-limiting",
  "response-ratelimiting",
  "syslog",
  "loggly",
  "datadog",
  "runscope",
  "ldap-auth",
  "statsd",
  "bot-detection",
  "aws-lambda",
  "request-termination",
}

local plugin_map = {}
for i = 1, #plugins do
  plugin_map[plugins[i]] = true
end

local deprecated_plugins = {
  "galileo",
}

local deprecated_plugin_map = {}
for _, plugin in ipairs(deprecated_plugins) do
  deprecated_plugin_map[plugin] = true
end

local headers = {
  HOST_OVERRIDE = "X-Host-Override",
  PROXY_LATENCY = "X-Kong-Proxy-Latency",
  UPSTREAM_LATENCY = "X-Kong-Upstream-Latency",
  CONSUMER_ID = "X-Consumer-ID",
  CONSUMER_CUSTOM_ID = "X-Consumer-Custom-ID",
  CONSUMER_USERNAME = "X-Consumer-Username",
  CREDENTIAL_USERNAME = "X-Credential-Username",
  RATELIMIT_LIMIT = "X-RateLimit-Limit",
  RATELIMIT_REMAINING = "X-RateLimit-Remaining",
  CONSUMER_GROUPS = "X-Consumer-Groups",
  FORWARDED_HOST = "X-Forwarded-Host",
  FORWARDED_PREFIX = "X-Forwarded-Prefix",
  ANONYMOUS = "X-Anonymous-Consumer",
  VIA = "Via",
  SERVER = "Server"
}

return {
  PLUGINS_AVAILABLE = plugin_map,
  DEPRECATED_PLUGINS = deprecated_plugin_map,
  -- non-standard headers, specific to Kong
  HEADERS = headers,
  -- TODO figure out how to organize headers and bit positions in code
  -- another (better?) way could be to keep the mask together 
  -- with header definitions, but not all headers have poitions..
  HEADER_MASKS = {
    [headers.PROXY_LATENCY] = 0x01,
    [headers.UPSTREAM_LATENCY] = 0x02,
    [headers.SERVER] = 0x04,
    [headers.VIA] = 0x08,
    latency = bor(0x01,0x02),
    server = bor(0x04,0x08),
  },
  RATELIMIT = {
    PERIODS = {
      "second",
      "minute",
      "hour",
      "day",
      "month",
      "year"
    }
  },
  REPORTS = {
    ADDRESS = "kong-hf.mashape.com",
    SYSLOG_PORT = 61828,
    STATS_PORT = 61829
  },
  DICTS = {
    "kong",
    "kong_cache",
    "kong_process_events",
    "kong_cluster_events",
    "kong_healthchecks",
  },
}
