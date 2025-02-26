SELECT * 
FROM notebooks_vendidos
LIMIT 100

--criando uma view para alterar a fonte original
ALTER VIEW vw_notebooks_vendidos as
SELECT *
  ,(latest_price * 0.063) AS real_latest_price_br --preço real em ptbr
  ,(old_price * 0.063) AS real_old_price_br --preço real em ptbr
  ,(discount / 100) AS adjusted_discount
FROM notebooks_vendidos

--visualizando como ficou a view
SELECT *
FROM vw_notebooks_vendidos

--média de preço das marcas
--acrescentando uma tratativa na brand 'lenovo' para 'Lenovo'
SELECT
CASE 
  WHEN brand = 'lenovo'THEN 'Lenovo'
  ELSE brand
END AS Brand
  ,AVG(real_latest_price_br) AS avg_real_latest_price_br
FROM vw_notebooks_vendidos
GROUP BY
CASE 
  WHEN brand = 'lenovo'THEN 'Lenovo'
  ELSE brand
END
ORDER BY 2 DESC

--média de preço das memórias
--acrescentando uma tratativa na ram_type para o grupo das 3 memorias principais
SELECT
CASE 
  WHEN ram_type = 'LPDDR3' THEN 'DDR3'
  WHEN ram_type IN ('LPDDR4','LPDDR4X') THEN 'DDR4'
ELSE ram_type
END AS ram_type
  ,AVG(real_latest_price_br) AS avg_real_latest_price_br
FROM vw_notebooks_vendidos
GROUP BY 
CASE 
  WHEN ram_type = 'LPDDR3' THEN 'DDR3'
  WHEN ram_type IN ('LPDDR4','LPDDR4X') THEN 'DDR4'
ELSE ram_type
END
ORDER BY 2 DESC
