/*
  Warnings:

  - You are about to drop the column `confidence` on the `documents` table. All the data in the column will be lost.
  - You are about to drop the column `createdById` on the `documents` table. All the data in the column will be lost.
  - You are about to drop the column `fileSize` on the `documents` table. All the data in the column will be lost.
  - You are about to drop the column `fileType` on the `documents` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `documents` table. All the data in the column will be lost.
  - You are about to drop the column `createdAt` on the `organization_members` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `organization_members` table. All the data in the column will be lost.
  - You are about to drop the column `logoUrl` on the `organizations` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `organizations` table. All the data in the column will be lost.
  - You are about to drop the column `avatarUrl` on the `users` table. All the data in the column will be lost.
  - You are about to drop the column `updatedAt` on the `users` table. All the data in the column will be lost.
  - You are about to drop the `document_analyses` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `organization_invitations` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `userId` to the `documents` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "document_analyses" DROP CONSTRAINT "document_analyses_documentId_fkey";

-- DropForeignKey
ALTER TABLE "documents" DROP CONSTRAINT "documents_createdById_fkey";

-- DropForeignKey
ALTER TABLE "organization_invitations" DROP CONSTRAINT "organization_invitations_organizationId_fkey";

-- AlterTable
ALTER TABLE "documents" DROP COLUMN "confidence",
DROP COLUMN "createdById",
DROP COLUMN "fileSize",
DROP COLUMN "fileType",
DROP COLUMN "updatedAt",
ADD COLUMN     "userId" TEXT NOT NULL;

-- AlterTable
ALTER TABLE "organization_members" DROP COLUMN "createdAt",
DROP COLUMN "updatedAt";

-- AlterTable
ALTER TABLE "organizations" DROP COLUMN "logoUrl",
DROP COLUMN "updatedAt";

-- AlterTable
ALTER TABLE "users" DROP COLUMN "avatarUrl",
DROP COLUMN "updatedAt";

-- DropTable
DROP TABLE "document_analyses";

-- DropTable
DROP TABLE "organization_invitations";

-- AddForeignKey
ALTER TABLE "documents" ADD CONSTRAINT "documents_userId_fkey" FOREIGN KEY ("userId") REFERENCES "users"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
