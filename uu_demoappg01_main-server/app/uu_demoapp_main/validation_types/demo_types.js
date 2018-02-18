const demoDtoInType = shape({
  code: hexa64Code().isRequired(),
  name: uu5String(4000)
});
