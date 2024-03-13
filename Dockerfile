FROM oven/bun:1 as base
WORKDIR /app


FROM base as install
RUN mkdir -p /app
COPY bun.lockb package.json index.ts tsconfig.json /app/
RUN bun install

FROM base as runner
COPY --from=install /app/node_modules /app/node_modules
COPY --from=install /app/index.ts /app/index.ts
COPY --from=install /app/bun.lockb /app/bun.lockb
COPY --from=install /app/package.json /app/package.json
COPY --from=install /app/tsconfig.json /app/tsconfig.json

EXPOSE 3333

USER bun

CMD ["bun", "run", "dev"]