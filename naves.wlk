
class Nave{
  var velocidad 
  var direccion
  var combustible
  method acelerar(cuanto){
    velocidad = (velocidad + cuanto).min(100000)

  }
  method desacelerar(cuanto){
    velocidad = (velocidad - cuanto).max(0)

  }
  method prepararViaje()
  method estaTranquila() {
  return combustible >= 4000 and velocidad <= 12000
}
  method recibirAmenaza(){
    self.escapar()
    self.avisar()
  }
  method escapar()
  method avisar()    
   
  method accionCombustibleYVelocidad(){
    self.cargarCombustible(30000)
    self.acelerar(5000)
  }
  method estaDeRelajo() {
    return self.estaTranquila() and self.condicionDeRelajo()
  }
  method condicionDeRelajo() 
  
  

  method cargarCombustible(cantidad){
    combustible = combustible + cantidad

  }
  method descargarCombustible(cantidad){
    combustible = (combustible - cantidad).max(0)

  }
  method combustible() = combustible
  

  method irHaciaElSol(){
    direccion = 10

  }
  method escaparDelSol(){
    direccion = -10

  }
  method ponerseParaleloAlSol(){
    direccion = 0

  }
  method acercarseUnPocoAlSol(){
    direccion = (direccion + 1).min(10)

  }
  method alejarseUnPocoDelSol(){
    direccion = (direccion - 1).max(-10)

  }
  
}
class NaveBaliza inherits Nave{
  var cantidadDeCambiosDeColor = 0
  var colorBaliza = "rojo"
  method cambiarColorDeBaliza(colorNuevo){
    colorBaliza = colorNuevo
    cantidadDeCambiosDeColor = cantidadDeCambiosDeColor + 1
  }
  
  method colorBalizaActual() = colorBaliza

   override method prepararViaje(){
    self.cambiarColorDeBaliza("verde")
    self.ponerseParaleloAlSol()
    self.accionCombustibleYVelocidad()
  }
  override method estaTranquila() {
    return super() and colorBaliza != "rojo"
  }
  override method escapar(){
    self.irHaciaElSol()  
    
  }
  override method avisar(){
    self.cambiarColorDeBaliza("rojo")
  }
  override method condicionDeRelajo() {
    return cantidadDeCambiosDeColor < 1
  }
}

class NaveDePasajeros inherits Nave{
  var property cantidadPasajeros 
   var racionesDeComida = 0
  var racionesDeBebida = 0
  var racionesDeComidaEntregadas = 1 * cantidadPasajeros
  method agregarRacionesDeComida(cantidad){
    racionesDeComida = racionesDeComida + cantidad

  }
  method agregarRacionesDeBebida(cantidad){
    racionesDeBebida = racionesDeBebida + cantidad

  }
  method entregarInsumoAnteAmenaza(){
    racionesDeComida = (racionesDeComida -1).max(0)
    racionesDeComidaEntregadas = racionesDeComidaEntregadas +1
    racionesDeBebida = (racionesDeBebida -2).max(0)

  }
  method racionesDeComida() = racionesDeComida
  method racionesDeBebida() = racionesDeBebida
  override method condicionDeRelajo() {
    return racionesDeComidaEntregadas < 50
  }
  
  override method prepararViaje(){
    self.agregarRacionesDeComida(4 * cantidadPasajeros)
    self.agregarRacionesDeBebida(6 * cantidadPasajeros)
    self.acercarseUnPocoAlSol()
    self.accionCombustibleYVelocidad()
  
  }
  override method escapar(){
    self.acelerar(velocidad * 2)
    
  }
  override method avisar(){
    self.entregarInsumoAnteAmenaza()
    
  }
}
class NaveDeCombate inherits Nave{
  const mensajes = []
  var visible = true
  var misilesDesplegados = true
  method ponerseVisible(){
    visible = true

  }
  method ponerseInvisible(){
    visible = false
}
method estaInvisible() {return visible}
method desplegarMisiles(){
    misilesDesplegados = true

  }
  method replegarMisiles(){
    misilesDesplegados = false

  }
  method misilesDesplegados() {return misilesDesplegados}
  method emitirMensaje(mensaje){
    mensajes.add(mensaje)
  }
  override method prepararViaje(){
    self.ponerseVisible()
    self.replegarMisiles()
    self.acelerar(15000)
    self.emitirMensaje("Saliendo en misión")
    self.accionCombustibleYVelocidad()
  }
  override method estaTranquila() {
    return super() and !misilesDesplegados 
  }
  override method escapar(){
    self.acercarseUnPocoAlSol()
    self.acercarseUnPocoAlSol()
    
  }
  override method avisar(){
    self.emitirMensaje("Amenaza recibida")
    
  }
  method mensajesEmitidos(){
    return mensajes
  }
  method primerMensajeEmitido(){
    return mensajes.first()
  }
  method ultimoMensajeEmitido(){
    return mensajes.last()
  }
  method esEscueta() {
  return !mensajes.any({ m => m.length() > 30 })
}

  method emitioMensaje(mensaje){
    return mensajes.contains(mensaje)
  }
} 
class NaveHospital inherits NaveDePasajeros{
  var quirófanosPreparados = true
  
  method prepararQuirófanos(){
    quirófanosPreparados = true

  }
  method usarQuirófanos(){
    quirófanosPreparados = false

  }
  method quirófanosEstánPreparados() {return quirófanosPreparados}
  override method estaTranquila() {
    return super() and !quirófanosPreparados
  }
  override method recibirAmenaza(){
    super()
    self.prepararQuirófanos()
  }
}
class NaveDeCombateSigilosa inherits NaveDeCombate{
  
  override method estaTranquila() {
    return super() and !self.estaInvisible()
  }
  override method escapar(){
    super()
    self.desplegarMisiles()
    self.ponerseInvisible()
  }
}
 