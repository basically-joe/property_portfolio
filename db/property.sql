DROP TABLE IF EXISTS property;

CREATE TABLE property(
  id SERIAL4 PRIMARY KEY,
  address VARCHAR(255),
  value INT2,
  number_of_bedrooms INT2,
  year_built INT2,
  buy_let_status VARCHAR(255),
  square_footage INT2,
  build_semi_flat_etc VARCHAR(255)
);
