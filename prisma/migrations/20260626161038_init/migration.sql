-- CreateTable
CREATE TABLE `cliente` (
    `id_cliente` INTEGER NOT NULL AUTO_INCREMENT,
    `nome_completo` VARCHAR(150) NOT NULL,
    `cpf` VARCHAR(14) NOT NULL,
    `celular` VARCHAR(20) NULL,
    `email` VARCHAR(120) NOT NULL,
    `data_nascimento` DATE NULL,

    UNIQUE INDEX `cliente_cpf_key`(`cpf`),
    UNIQUE INDEX `cliente_email_key`(`email`),
    PRIMARY KEY (`id_cliente`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `endereco` (
    `id_endereco` INTEGER NOT NULL AUTO_INCREMENT,
    `cep` VARCHAR(10) NOT NULL,
    `logradouro` VARCHAR(150) NOT NULL,
    `numero` VARCHAR(20) NOT NULL,
    `cidade` VARCHAR(100) NOT NULL,
    `estado` CHAR(2) NOT NULL,
    `id_cliente` INTEGER NOT NULL,

    PRIMARY KEY (`id_endereco`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `categoria` (
    `id_categoria` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,

    PRIMARY KEY (`id_categoria`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subcategoria` (
    `id_subcategoria` INTEGER NOT NULL AUTO_INCREMENT,
    `nome` VARCHAR(100) NOT NULL,
    `id_categoria` INTEGER NOT NULL,

    PRIMARY KEY (`id_subcategoria`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `produto` (
    `id_produto` INTEGER NOT NULL AUTO_INCREMENT,
    `modelo` VARCHAR(120) NOT NULL,
    `fabricante` VARCHAR(120) NOT NULL,
    `preco_base` DECIMAL(10, 2) NOT NULL,
    `quantidade_disponivel` INTEGER NOT NULL DEFAULT 0,
    `id_subcategoria` INTEGER NOT NULL,

    PRIMARY KEY (`id_produto`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `numero_serie` (
    `id_numero_serie` INTEGER NOT NULL AUTO_INCREMENT,
    `numero_serie` VARCHAR(100) NOT NULL,
    `id_produto` INTEGER NOT NULL,

    UNIQUE INDEX `numero_serie_numero_serie_key`(`numero_serie`),
    PRIMARY KEY (`id_numero_serie`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `compra` (
    `id_compra` INTEGER NOT NULL AUTO_INCREMENT,
    `data_hora` DATETIME(0) NOT NULL,
    `desconto` DECIMAL(10, 2) NULL DEFAULT 0.00,
    `forma_pagamento` VARCHAR(50) NOT NULL,
    `total_compra` DECIMAL(10, 2) NOT NULL,
    `id_cliente` INTEGER NOT NULL,
    `id_endereco` INTEGER NOT NULL,

    PRIMARY KEY (`id_compra`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `item_compra` (
    `id_item_compra` INTEGER NOT NULL AUTO_INCREMENT,
    `quantidade` INTEGER NOT NULL,
    `preco_unitario` DECIMAL(10, 2) NOT NULL,
    `subtotal` DECIMAL(10, 2) NOT NULL,
    `id_compra` INTEGER NOT NULL,
    `id_produto` INTEGER NOT NULL,

    PRIMARY KEY (`id_item_compra`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `endereco` ADD CONSTRAINT `endereco_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `subcategoria` ADD CONSTRAINT `subcategoria_id_categoria_fkey` FOREIGN KEY (`id_categoria`) REFERENCES `categoria`(`id_categoria`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `produto` ADD CONSTRAINT `produto_id_subcategoria_fkey` FOREIGN KEY (`id_subcategoria`) REFERENCES `subcategoria`(`id_subcategoria`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `numero_serie` ADD CONSTRAINT `numero_serie_id_produto_fkey` FOREIGN KEY (`id_produto`) REFERENCES `produto`(`id_produto`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `compra` ADD CONSTRAINT `compra_id_cliente_fkey` FOREIGN KEY (`id_cliente`) REFERENCES `cliente`(`id_cliente`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `compra` ADD CONSTRAINT `compra_id_endereco_fkey` FOREIGN KEY (`id_endereco`) REFERENCES `endereco`(`id_endereco`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `item_compra` ADD CONSTRAINT `item_compra_id_compra_fkey` FOREIGN KEY (`id_compra`) REFERENCES `compra`(`id_compra`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `item_compra` ADD CONSTRAINT `item_compra_id_produto_fkey` FOREIGN KEY (`id_produto`) REFERENCES `produto`(`id_produto`) ON DELETE RESTRICT ON UPDATE CASCADE;
