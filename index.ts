import "dotenv/config";
import { PrismaClient } from "@prisma/client";
import { PrismaMariaDb } from "@prisma/adapter-mariadb";

const adapter = new PrismaMariaDb({
    host: process.env.DATABASE_HOST!,
    port: Number(process.env.DATABASE_PORT!),
    user: process.env.DATABASE_USER!,
    password: process.env.DATABASE_PASSWORD!,
    database: process.env.DATABASE_NAME!,
    connectionLimit: 5,
});

const prisma = new PrismaClient({ adapter });

async function main() {
    const numero = Date.now();

    const clienteCriado = await prisma.cliente.create({
        data: {
            nomeCompleto: "Maria Oliveira",
            cpf: String(numero).slice(0, 14),
            celular: "92999999999",
            email: `maria${numero}@email.com`,
            dataNascimento: new Date("2000-05-10"),
        },
    });

    console.log("Cliente cadastrado:");
    console.log(clienteCriado);

    const clientes = await prisma.cliente.findMany();

    console.log("Lista de clientes:");
    console.log(clientes);

    const clienteEncontrado = await prisma.cliente.findUnique({
        where: {
            idCliente: clienteCriado.idCliente,
        },
    });

    console.log("Cliente encontrado pelo ID:");
    console.log(clienteEncontrado);

    const clienteAtualizado = await prisma.cliente.update({
        where: {
            idCliente: clienteCriado.idCliente,
        },
        data: {
            nomeCompleto: "Maria Oliveira Atualizada",
            celular: "92888888888",
        },
    });

    console.log("Cliente atualizado:");
    console.log(clienteAtualizado);

    const clienteDeletado = await prisma.cliente.delete({
        where: {
            idCliente: clienteCriado.idCliente,
        },
    });

    console.log("Cliente deletado:");
    console.log(clienteDeletado);
}

main()
    .then(async () => {
        await prisma.$disconnect();
    })
    .catch(async (e) => {
        console.error(e);
        await prisma.$disconnect();
        process.exit(1);
    });