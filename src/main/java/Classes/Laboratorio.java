package Classes;

/**
 *
 * @author Juan
 */
public class Laboratorio {
    // Atributos
    private int id_lab;
    private String nombre;
    private String direccion;
    private String telefono;
    private String email;

    // Constructor Vacío
    public Laboratorio() {
    }

    // Constructor Lleno
    public Laboratorio(int id_lab, String nombre, String direccion, String telefono, String email) {
        this.id_lab = id_lab;
        this.nombre = nombre;
        this.direccion = direccion;
        this.telefono = telefono;
        this.email = email;
    }

    // Getters & Setters
    public int getId_lab() {
        return id_lab;
    }

    public void setId_lab(int id_lab) {
        this.id_lab = id_lab;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
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
}