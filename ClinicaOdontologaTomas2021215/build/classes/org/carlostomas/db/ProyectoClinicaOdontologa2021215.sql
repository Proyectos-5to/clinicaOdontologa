drop database if exists ProyectoClinicaOdontologa2021215;
create database ProyectoClinicaOdontologa2021215;
use ProyectoClinicaOdontologa2021215;

create table Pacientes(
   codigoPaciente int not null,
   nombresPaciente varchar(50) not null,
   apellidosPaciente varchar(50) not null,
   sexo char not null,
   fechaNacimiento date not null,
   direccionPaciente varchar(100) not null,
   telefonoPersonal varchar(8) not null,
   fechaPrimeraVisita date,
   primary key PK_codigoPaciente (codigoPaciente)
   
);

create table Especialidades(
   codigoEspecialidad int not null auto_increment,
   descripcion varchar(100) not null,
   primary key PK_codigoEspecialidad (codigoEspecialidad)
);

create table Medicamentos(
   codigoMedicamento int not null auto_increment,
   nombreMedicamento varchar(100) not null,
   primary key PK_codigoMedicamento (codigoMedicamento)
);

create table Doctores(
   numeroColegiado int not null auto_increment	,
   nombresDoctor varchar(50) not null,
   apellidosDoctor varchar(50) not null,
   telefonoContacto varchar(8) not null,
   codigoEspecialidad int not null,
   primary key PK_numeroColegiado (numeroColegiado),
      constraint FK_Doctores_Especialidades foreign key (codigoEspecialidad)
	    references Especialidades (codigoEspecialidad)
);

create table Recetas(
   codigoReceta int not null auto_increment,
   fechaReceta date not null,
   numeroColegiado int not null,
   primary key PK_codigoReceta (codigoReceta),
     constraint FK_Recetas_Doctores foreign key (numeroColegiado)
      references Doctores (numeroColegiado)
);

create table DetalleReceta(
   codigoDetalleReceta int not null auto_increment,
   dosis varchar(100) not null,
   codigoReceta int not null,
   codigoMedicamento int not null,
   primary key PK_codigoDetalleReceta (codigoDetalleReceta),
   constraint FK_detalleReceta_Recetas foreign key (codigoReceta)
     references Recetas (codigoReceta),
   constraint FK_detalleReceta_Medicamentos foreign key (codigoMedicamento)
     references Medicamentos (codigoMedicamento)
   
);

create table Citas(
   codigoCita int not null auto_increment,
   fechaCita date not null,
   horaCita time not null,
   tratamiento varchar(150),
   descripcionCondActual varchar(255) not null,
   codigoPaciente int not null,
   numeroColegiado int not null,
   primary key PK_codigoCita (codigoCita),
   constraint FK_Citas_Pacientes foreign key (codigoPaciente)
     references Pacientes (codigoPaciente),
   constraint FK_Citas_Doctores foreign key (numeroColegiado)
     references Doctores (numeroColegiado)
);
-- ----------------------Prodecimientos almacenado---------
-- ----------------------Pacientes AGREGAR -------------------------

Delimiter //
  create procedure sp_AgregarPaciente(in codigoPaciente int, in nombresPaciente varchar(50),
  in apellidosPaciente varchar(50), in sexo char, in fechaNacimiento date,
  in direccionPaciente varchar(100) , in telefonoPersonal varchar(8), in fechaPrimeraVisita date)
   begin 
       insert into Pacientes (codigoPaciente, nombresPaciente ,apellidosPaciente,sexo,
        fechaNacimiento,direccionPaciente,telefonoPersonal,fechaPrimeraVisita)
        
         values (codigoPaciente, nombresPaciente ,apellidosPaciente, upper(sexo),
          fechaNacimiento,direccionPaciente,telefonoPersonal,fechaPrimeraVisita);
   end//
Delimiter ;

call sp_AgregarPaciente(100,'Carlos Estuardo','Tomas Mejia','m','2005-03-14','zona 7 colonia quinta samayoa 8-30','32769783',now())
call sp_AgregarPaciente(200,'Carlos Estuardo','Tomas Mejia','m','2005-03-14','zona 7 colonia quinta samayoa 8-30','32769783',now())



-- Listar -------------
Delimiter //
    create procedure sp_ListarPacientes()
       begin 
        select
           p.codigoPaciente, 
           p.nombresPaciente, 
           p.apellidosPaciente, 
           p.sexo, 
           p.fechaNacimiento, 
           p.direccionPaciente, 
           p.telefonoPersonal, 
           p.fechaPrimeraVisita
        from Pacientes p;
        end//
Delimiter ;

call sp_ListarPacientes();

-- buscar----------------
Delimiter //
    create procedure sp_BuscarPaciente(in codPaciente int)
       begin 
        select
           p.codigoPaciente, 
           p.nombresPaciente, 
           p.apellidosPaciente, 
           p.sexo, 
           p.fechaNacimiento, 
           p.direccionPaciente, 
           p.telefonoPersonal, 
           p.fechaPrimeraVisita
        from Pacientes p
			where codigoPaciente = codPaciente;
        end//
Delimiter ;

call sp_BuscarPaciente(100);

-- Eliminar----
Delimiter //
    create Procedure sp_EliminarPaciente(in codPaciente int)
    begin
     Delete from Pacientes
        where codigoPaciente = codPaciente;
    end//

Delimiter ;

call sp_EliminarPaciente(100);
call sp_ListarPacientes();

-- -----------Editar------------
Delimiter //
create Procedure sp_EditarPaciente(in codPaciente int, in nomPaciente varchar(50), in apePaciente varchar(50), in sx char, 
in fechaNa date, in dircPaciente varchar(100), in telPersonal varchar(8), in fechaPV date)
  begin 
   update Pacientes p
    set
    p.nombresPaciente = nomPaciente,
    p.apellidosPaciente = apePaciente,
    p.sexo = sx,
    p.fechaNacimiento = fechaNa,
    p.direccionPaciente = dircPaciente,
    p.telefonoPersonal = telPersonal,
    p.fechaPrimeraVisita = fechaPV
    where codigoPaciente = codPaciente;
   end//
Delimiter ;




