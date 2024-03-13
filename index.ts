Bun.serve({
  fetch() {
    return new Response("Hello, Gustavo")
  },
  port: 3333,
})