package Classes;

import java.util.Date;

/**
 *
 * @author Juan
 */
public class Usuario {
    // Atributos
    private int id_usuario;
    private String doc;           // TI, CC, CE, PASAPORTE
    private String tipo_doc;       // Número de Identificación
    private String nombre;
    private String apellido;
    private Date fecha_nacimiento;
    private String telefono;
    private String email;
    private String direccion;
    private String tipo_usuario;    // CLIENTE, PERSONAL
    private String cod;             // Código de Verificación (Personal)
    private String cargo;            // (Personal)
    private Date fecha_contratacion; // (Personal)
    
    // Constructor Vacío
    public Usuario() {
    }
    
    // Constructor Lleno
    public Usuario(int id_usuario, String doc, String tipo_doc, String nombre, String apellido, Date fecha_nacimiento, String telefono, String email, String direccion, String tipo_usuario, String cod, String cargo, Date fecha_contratacion) {
        this.id_usuario = id_usuario;
        this.doc = doc;
        this.tipo_doc = tipo_doc;
        this.nombre = nombre;
        this.apellido = apellido;
        this.fecha_nacimiento = fecha_nacimiento;
        this.telefono = telefono;
        this.email = email;
        this.direccion = direccion;
        this.tipo_usuario = tipo_usuario;
        this.cod = cod;
        this.cargo = cargo;
        this.fecha_contratacion = fecha_contratacion;
    }
    
    // Getters & Setters
    public int getId_usuario() {
        return id_usuario;
    }

    public void setId_usuario(int id_usuario) {
        this.id_usuario = id_usuario;
    }

    public String getDoc() {
        return doc;
    }

    public void setDoc(String doc) {
        this.doc = doc;
    }

    public String getTipo_doc() {
        return tipo_doc;
    }

    public void setTipo_doc(String tipo_doc) {
        this.tipo_doc = tipo_doc;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public Date getFecha_nacimiento() {
        return fecha_nacimiento;
    }

    public void setFecha_nacimiento(Date fecha_nacimiento) {
        this.fecha_nacimiento = fecha_nacimiento;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getTipo_usuario() {
        return tipo_usuario;
    }

    public void setTipo_usuario(String tipo_usuario) {
        this.tipo_usuario = tipo_usuario;
    }

    public String getCod() {
        return cod;
    }

    public void setCod(String cod) {
        this.cod = cod;
    }

    public String getCargo() {
        return cargo;
    }

    public void setCargo(String cargo) {
        this.cargo = cargo;
    }

    public Date getFecha_contratacion() {
        return fecha_contratacion;
    }

    public void setFecha_contratacion(Date fecha_contratacion) {
        this.fecha_contratacion = fecha_contratacion;
    }
}
