Code.require_file("Util.ex")

defmodule Cuadrados do
  @margen 15

  def generar() do
    lado = Util.ingresar("Lado del cuadrado inicial (L): ", :entero)
    cantidad = Util.ingresar("Cantidad de cuadrados: ", :entero)
    reduccion = Util.ingresar("Reducción del lado en cada paso: ", :entero)

    tamano = lado + 2 * @margen

    cuadrados = dibujar_cuadrados(@margen, @margen, lado, cantidad, reduccion)

    svg = """
    <svg xmlns="http://www.w3.org/2000/svg"
    width="#{tamano}" height="#{tamano}"
    viewBox="0 0 #{tamano} #{tamano}">
    #{cuadrados}
    </svg>
    """

    Util.con_archivo("cuadrados.svg", fn archivo ->
      Util.escribir_linea(archivo, svg)
    end)

    Util.mostrar_mensaje("Imagen creada: cuadrados.svg")
  end

  defp dibujar_cuadrados(_x, _y, lado, faltan, _reduccion)
       when faltan <= 0 or lado <= 0,
       do: ""

  # Caso recursivo: dibuja un cuadrado y calcula el siguiente
  defp dibujar_cuadrados(x, y, lado, faltan, reduccion) do
    cuadrado = """
    <rect x="#{x}" y="#{y}"
    width="#{lado}" height="#{lado}"
    fill="none" stroke="#2865a6"
    stroke-width="3"/>
    """

    siguiente_x = x + reduccion / 2
    siguiente_y = y + reduccion / 2
    siguiente_lado = lado - reduccion

    cuadrado <>
      dibujar_cuadrados(siguiente_x, siguiente_y, siguiente_lado, faltan - 1, reduccion)
  end
end

Cuadrados.generar()
