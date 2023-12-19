local router = [
  {
    method: 'ws',
    pattern: '/http/ws',
    dialer: 'ws',
    access: 'test access token',
  },
  {
    method: 'POST',
    pattern: '/http2',
    dialer: 'h2c-ws',
  },
  {
    method: 'PUT',
    pattern: '/http2',
    dialer: 'h2-ws',
  },
  {
    method: 'PATCH',
    pattern: '/http2',
    dialer: 'h2c-ws',
    access: 'test access token',
  },
];
{
  logger: {
    level: 'debug',
    // source: true,
  },
  pool: {
    size: 1024 * 32,
    cache: 128,
  },
  dialer: [
    {
      tag: 'tcp',
      timeout: '200ms',
      url: 'basic://example.com?addr=localhost:2000',
    },
    {
      tag: 'tcp+tls',
      timeout: '200ms',
      url: 'basic+tls://example.com?addr=localhost:2443',
      allowInsecure: true,
    },
    {
      tag: 'pipe',
      timeout: '200ms',
      url: 'basic://?network=pipe&addr=pipe',
    },
    {
      tag: 'pipe+tls',
      timeout: '200ms',
      url: 'basic://?network=pipe&addr=pipe%2Btls',
    },
    {
      tag: 'unix',
      timeout: '200ms',
      url: 'basic://?network=unix&addr=@tcp-http.socket',
    },
    {
      tag: 'unix+tls',
      timeout: '200ms',
      url: 'basic+tls://?network=unix&addr=@tcp-https.socket',
      allowInsecure: true,
    },
    {
      tag: 'ws',
      timeout: '200ms',
      url: 'ws://example.com/test/ws',
      network: 'unix',
      addr: '@tcp-http.socket',
    },
    {
      tag: 'wss',
      timeout: '200ms',
      url: 'wss://example.com/test/wss',
      network: 'unix',
      addr: '@tcp-https.socket',
      allowInsecure: true,
    },
    {
      tag: 'h2c-ws',
      timeout: '200ms',
      url: 'ws://example.com/test/ws',
      network: 'unix',
      addr: '@tcp-http.socket',
    },
    {
      tag: 'h2-ws',
      timeout: '200ms',
      url: 'https://127.0.0.1:4443/http2',
      method: 'PATCH',
      access: 'test access token',
      allowInsecure: true,
    },
    {
      tag: 'portal',
      timeout: '200ms',
      url: 'portal://portal',
      bridge: 'dialer tag',
    },
  ],
  bridge: [
    {
      network: 'pipe',
      addr: 'portal',
    },
  ],
  portal: [
    {
      tag: 'portal',
      network: 'pipe',
      address: 'portal',
    },
  ],
  listener: [
    {
      network: 'pipe',
      address: 'pipe',
      close: '1s',
      dialer: 'tcp',
    },
    {
      network: 'pipe',
      address: 'pipe+tls',
      certFile: 'test.crt',
      keyFile: 'test.key',
      close: '1s',
      dialer: 'tcp+tls',
    },
    {
      network: 'unix',
      address: '@tcp-http.socket',
      close: '1s',
      dialer: 'pipe',
    },
    {
      network: 'unix',
      address: '@tcp-https.socket',
      certFile: 'test.crt',
      keyFile: 'test.key',
      close: '1s',
      dialer: 'pipe+tls',
    },
    {
      network: 'tcp',
      address: ':3000',
      close: '1s',
      dialer: 'unix',
    },
    {
      network: 'tcp',
      address: ':3443',
      certFile: 'test.crt',
      keyFile: 'test.key',
      close: '1s',
      dialer: 'unix+tls',
    },
    {
      mode: 'http',
      network: 'tcp',
      address: ':4000',
      close: '1s',
      router: router,
    },
    {
      mode: 'http',
      network: 'tcp',
      address: ':4443',
      certFile: 'test.crt',
      keyFile: 'test.key',
      close: '1s',
      router: router,
    },
  ],
}
