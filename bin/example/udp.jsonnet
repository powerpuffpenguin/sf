{
  listener: [
    {
      network: 'tcp',
      addr: ':9000',
      mode: 'http',
      router: [
        {
          method: 'API',
          pattern: '/api',
        },
      ],
    },
  ],
  udp: [
    {
      // udp listen host:port
      listen: ':1053',
      // remote target addr
      to: '8.8.8.8:53',
      // udp max frame length, default 1024*2
      size: 1500,
      // udp timeout, default 3m
      timeout: '3m',
    },
  ],
}
