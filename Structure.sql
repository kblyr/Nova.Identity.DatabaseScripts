CREATE SCHEMA "Identity";

CREATE TABLE IF NOT EXISTS "Identity"."Boundary"
(
    "Id" SMALLINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Name" TEXT NOT NULL,
    "LookupKey" TEXT,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "UpdatedById" INT,
    "UpdatedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_Boundary" PRIMARY KEY("Id"),
    CONSTRAINT "UQ_Boundary_LookupKey" UNIQUE("LookupKey")
);

CREATE TABLE IF NOT EXISTS "Identity"."ClientApp"
(
    "Id" SMALLINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Name" TEXT NOT NULL,
    "LookupKey" TEXT,
    "BoundaryId" SMALLINT,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "UpdatedById" INT,
    "UpdatedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_ClientApp" PRIMARY KEY("Id"),
    CONSTRAINT "UQ_ClientApp_LookupKey" UNIQUE("LookupKey")
);

CREATE TABLE IF NOT EXISTS "Identity"."ClientDevice"
(
    "Id" BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "IpAddress" TEXT NOT NULL,
    "Name" TEXT NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "UpdatedById" INT,
    "UpdatedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_ClientDevice" PRIMARY KEY("Id"),
    CONSTRAINT "UQ_ClientDevice_IpAddress" UNIQUE("IpAddress"),
    CONSTRAINT "UQ_ClientDevice_Name" UNIQUE("Name")
);

CREATE TABLE IF NOT EXISTS "Identity"."Permission"
(
    "Id" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Name" TEXT NOT NULL,
    "LookupKey" TEXT,
    "BoundaryId" SMALLINT,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "UpdatedById" INT,
    "UpdatedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_Permission" PRIMARY KEY("Id"),
    CONSTRAINT "UQ_Permission_LookupKey" UNIQUE("LookupKey")
);

CREATE TABLE IF NOT EXISTS "Identity"."Role"
(
    "Id" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Name" TEXT NOT NULL,
    "LookupKey" TEXT,
    "BoundaryId" SMALLINT,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "UpdatedById" INT,
    "UpdatedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_Role" PRIMARY KEY("Id"),
    CONSTRAINT "UQ_Role_LookupKey" UNIQUE("LookupKey")
);

CREATE TABLE IF NOT EXISTS "Identity"."RolePermission"
(
    "Id" BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "RoleId" INT NOT NULL,
    "PermissionId" INT NOT NULL,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_RolePermission" PRIMARY KEY("Id")
);

CREATE TABLE IF NOT EXISTS "Identity"."User"
(
    "Id" INT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "Username" TEXT NOT NULL,
    "HashedPassword" TEXT NOT NULL,
    "IsActive" BOOLEAN NOT NULL,
    "IsPasswordChangeRequired" BOOLEAN NOT NULL,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "UpdatedById" INT,
    "UpdatedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_User" PRIMARY KEY("Id"),
    CONSTRAINT "UQ_User_Username" UNIQUE("Username")
);

CREATE TABLE IF NOT EXISTS "Identity"."UserClientApp"
(
    "Id" BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "UserId" INT NOT NULL,
    "ClientAppId" SMALLINT NOT NULL,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_UserClientApp" PRIMARY KEY("Id")
);

CREATE TABLE IF NOT EXISTS "Identity"."UserClientDevice"
(
    "Id" BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "UserId" INT NOT NULL,
    "ClientDeviceId" BIGINT NOT NULL,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_UserClientDevice" PRIMARY KEY("Id")
);

CREATE TABLE IF NOT EXISTS "Identity"."UserRole"
(
    "Id" BIGINT NOT NULL GENERATED ALWAYS AS IDENTITY,
    "UserId" INT NOT NULL,
    "RoleId" INT NOT NULL,
    "IsDeleted" BOOLEAN NOT NULL,
    "InsertedById" INT,
    "InsertedOn" TIMESTAMP WITH TIME ZONE,
    "DeletedById" INT,
    "DeletedOn" TIMESTAMP WITH TIME ZONE,
    CONSTRAINT "PK_UserRole" PRIMARY KEY("Id")
);

ALTER TABLE "Identity"."ClientApp" ADD CONSTRAINT "FK_ClientApp_BoundaryId" FOREIGN KEY("BoundaryId") REFERENCES "Identity"."Boundary"("Id") ON DELETE RESTRICT;

ALTER TABLE "Identity"."Permission" ADD CONSTRAINT "FK_Permission_BoundaryId" FOREIGN KEY("BoundaryId") REFERENCES "Identity"."Boundary"("Id") ON DELETE RESTRICT;

ALTER TABLE "Identity"."Role" ADD CONSTRAINT "FK_Role_BoundaryId" FOREIGN KEY("BoundaryId") REFERENCES "Identity"."Boundary"("Id") ON DELETE RESTRICT;

ALTER TABLE "Identity"."RolePermission" ADD CONSTRAINT "FK_RolePermission_RoleId" FOREIGN KEY("RoleId") REFERENCES "Identity"."Role"("Id") ON DELETE RESTRICT;
ALTER TABLE "Identity"."RolePermission" ADD CONSTRAINT "FK_RolePermission_PermissionId" FOREIGN KEY("PermissionId") REFERENCES "Identity"."Permission"("Id") ON DELETE RESTRICT;

ALTER TABLE "Identity"."UserClientApp" ADD CONSTRAINT "FK_UserClientApp_UserId" FOREIGN KEY("UserId") REFERENCES "Identity"."User"("Id") ON DELETE RESTRICT;
ALTER TABLE "Identity"."UserClientApp" ADD CONSTRAINT "FK_UserClientApp_ClientAppId" FOREIGN KEY("ClientAppId") REFERENCES "Identity"."ClientApp"("Id") ON DELETE RESTRICT;

ALTER TABLE "Identity"."UserClientDevice" ADD CONSTRAINT "FK_UserClientDevice_UserId" FOREIGN KEY("UserId") REFERENCES "Identity"."User"("Id") ON DELETE RESTRICT;
ALTER TABLE "Identity"."UserClientDevice" ADD CONSTRAINT "FK_UserClientDevice_ClientDeviceId" FOREIGN KEY("ClientDeviceId") REFERENCES "Identity"."ClientDevice"("Id") ON DELETE RESTRICT;

ALTER TABLE "Identity"."UserRole" ADD CONSTRAINT "FK_UserRole_UserId" FOREIGN KEY("UserId") REFERENCES "Identity"."User"("Id") ON DELETE RESTRICT;
ALTER TABLE "Identity"."UserRole" ADD CONSTRAINT "FK_UserRole_RoleId" FOREIGN KEY("RoleId") REFERENCES "Identity"."Role"("Id") ON DELETE RESTRICT;