// Produto → Marca
MATCH (p:Produto {descricao: 'Notebook Dell Inspiron 15'}), (m:Marca {nome: 'Dell'})
CREATE (p)-[:FABRICADO_POR]->(m);

MATCH (p:Produto {descricao: 'Smartphone Samsung Galaxy S21'}), (m:Marca {nome: 'Samsung'})
CREATE (p)-[:FABRICADO_POR]->(m);

MATCH (p:Produto {descricao: 'Fone de Ouvido Sony WH-1000XM4'}), (m:Marca {nome: 'Sony'})
CREATE (p)-[:FABRICADO_POR]->(m);

MATCH (p:Produto {descricao: 'Monitor LG UltraGear 27'}), (m:Marca {nome: 'LG'})
CREATE (p)-[:FABRICADO_POR]->(m);

MATCH (dell:Marca {nome: 'Dell'}), (p1:Produto {descricao: 'Notebook Dell XPS 13'})
CREATE (p1)-[:FABRICADO_POR]->(dell);

MATCH (dell:Marca {nome: 'Dell'}), (p2:Produto {descricao: 'Desktop Dell OptiPlex 7080'})
CREATE (p2)-[:FABRICADO_POR]->(dell);

MATCH (samsung:Marca {nome: 'Samsung'}), (p3:Produto {descricao: 'Smartphone Samsung Galaxy Note 20'})
CREATE (p3)-[:FABRICADO_POR]->(samsung);

MATCH (samsung:Marca {nome: 'Samsung'}), (p4:Produto {descricao: 'Smartwatch Samsung Galaxy Watch 4'})
CREATE (p4)-[:FABRICADO_POR]->(samsung);

MATCH (sony:Marca {nome: 'Sony'}), (p5:Produto {descricao: 'Fone de Ouvido Sony WF-1000XM3'})
CREATE (p5)-[:FABRICADO_POR]->(sony);

MATCH (sony:Marca {nome: 'Sony'}), (p6:Produto {descricao: 'Caixa de Som Sony SRS-XB12'})
CREATE (p6)-[:FABRICADO_POR]->(sony);

MATCH (lg:Marca {nome: 'LG'}), (p7:Produto {descricao: 'Monitor LG 34WN80C-B'})
CREATE (p7)-[:FABRICADO_POR]->(lg);

MATCH (lg:Marca {nome: 'LG'}), (p8:Produto {descricao: 'Monitor LG 27MP59G-P'})
CREATE (p8)-[:FABRICADO_POR]->(lg);

// Produto → Categoria
MATCH (p:Produto {descricao: 'Notebook Dell Inspiron 15'}), (c:Categoria {descricao: 'Tecnologia'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Smartphone Samsung Galaxy S21'}), (c:Categoria {descricao: 'Eletrônicos'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Fone de Ouvido Sony WH-1000XM4'}), (c:Categoria {descricao: 'Áudio'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Monitor LG UltraGear 27'}), (c:Categoria {descricao: 'Periféricos'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Notebook Dell XPS 13'}), (c:Categoria {descricao: 'Tecnologia'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Desktop Dell OptiPlex 7080'}), (c:Categoria {descricao: 'Tecnologia'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Smartphone Samsung Galaxy Note 20'}), (c:Categoria {descricao: 'Eletrônicos'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Smartwatch Samsung Galaxy Watch 4'}), (c:Categoria {descricao: 'Wearables'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Fone de Ouvido Sony WF-1000XM3'}), (c:Categoria {descricao: 'Áudio'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Caixa de Som Sony SRS-XB12'}), (c:Categoria {descricao: 'Áudio'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Monitor LG 34WN80C-B'}), (c:Categoria {descricao: 'Periféricos'})
CREATE (p)-[:PERTENCE_A]->(c);

MATCH (p:Produto {descricao: 'Monitor LG 27MP59G-P'}), (c:Categoria {descricao: 'Periféricos'})
CREATE (p)-[:PERTENCE_A]->(c);

// Cliente → Produto
MATCH (c:Cliente {nome: 'Ana'}), (p:Produto {descricao: 'Notebook Dell Inspiron 15'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-01T10:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-02T15:30:00')}]->(p),
       (c)-[:AVALIOU {datahora: datetime('2025-07-03T11:00:00'), estrela: 5, comentario: 'Excelente notebook, recomendo!'}]->(p);

MATCH (c:Cliente {nome: 'Bruno'}), (p:Produto {descricao: 'Smartphone Samsung Galaxy S21'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-03T11:00:00')}]->(p);
MATCH (c:Cliente {nome: 'Bruno'}), (p:Produto {descricao: 'Smartwatch Samsung Galaxy Watch 4'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-03T12:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-03T12:30:00')}]->(p),
       (c)-[:AVALIOU {datahora: datetime('2025-07-05T12:00:00'), estrela: 4}]->(p);

MATCH (c:Cliente {nome: 'Carla'}), 
      (p1:Produto {descricao: 'Monitor LG UltraGear 27'}), 
      (p2:Produto {descricao: 'Desktop Dell OptiPlex 7080'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-04T09:00:00')}]->(p1),
       (c)-[:VISUALIZOU {datahora: datetime('2025-07-04T09:05:00')}]->(p2),
       (c)-[:COMPROU {datahora: datetime('2025-07-04T10:00:00')}]->(p2);

MATCH (c:Cliente {nome: 'Diego'}), (p:Produto {descricao: 'Fone de Ouvido Sony WH-1000XM4'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-05T14:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-05T14:30:00')}]->(p),
       (c)-[:AVALIOU {datahora: datetime('2025-07-10T11:00:00'), estrela: 3, comentario: 'Bom som, mas esperava mais'}]->(p);

MATCH (c:Cliente {nome: 'Ana'}), (p:Produto {descricao: 'Monitor LG 27MP59G-P'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-06T08:00:00')}]->(p);

MATCH (c:Cliente {nome: 'Bruno'}), (p:Produto {descricao: 'Notebook Dell XPS 13'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-06T09:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-06T09:30:00')}]->(p);

MATCH (c:Cliente {nome: 'Carla'}), (p:Produto {descricao: 'Caixa de Som Sony SRS-XB12'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-07T10:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-08T09:30:00')}]->(p),
       (c)-[:AVALIOU {datahora: datetime('2025-07-12T11:00:00'), estrela: 4}]->(p);

MATCH (c:Cliente {nome: 'Diego'}), (p:Produto {descricao: 'Smartphone Samsung Galaxy Note 20'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-07T11:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-07T11:30:00')}]->(p),
       (c)-[:AVALIOU {datahora: datetime('2025-07-11T10:00:00'), estrela: 5, comentario: 'Ótimo smartphone!'}]->(p);

MATCH (c:Cliente {nome: 'Ana'}), (p:Produto {descricao: 'Desktop Dell OptiPlex 7080'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-08T10:00:00')}]->(p);

MATCH (c:Cliente {nome: 'Bruno'}), (p:Produto {descricao: 'Monitor LG 34WN80C-B'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-08T14:00:00')}]->(p),
       (c)-[:COMPROU {datahora: datetime('2025-07-08T14:15:00')}]->(p),	
       (c)-[:AVALIOU {datahora: datetime('2025-07-14T17:00:00'), estrela: 3}]->(p);



MATCH (c:Cliente {nome: 'Carla'}), (p:Produto {descricao: 'Smartphone Samsung Galaxy S21'})
CREATE (c)-[:COMPROU {datahora: datetime('2025-07-09T15:00:00')}]->(p),
       (c)-[:VISUALIZOU {datahora: datetime('2025-07-09T12:55:00')}]->(p),
       (c)-[:AVALIOU {datahora: datetime('2025-07-10T11:00:00'), estrela: 4}]->(p);

MATCH (c:Cliente {nome: 'Bruno'}), (p:Produto {descricao: 'Notebook Dell Inspiron 15'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-11T10:00:00')}]->(p),
       (c)-[:COMPROU   {datahora: datetime('2025-07-11T10:30:00')}]->(p),
       (c)-[:AVALIOU   {datahora: datetime('2025-07-12T09:00:00'), estrela: 5}]->(p);

MATCH  (ana:Cliente {nome: 'Ana'}),
       (wf:Produto  {descricao: 'Fone de Ouvido Sony WF-1000XM3'}),
       (box:Produto {descricao: 'Caixa de Som Sony SRS-XB12'})
CREATE (ana)-[:VISUALIZOU {datahora: datetime('2025-07-12T15:00:00')}]->(wf),
       (ana)-[:VISUALIZOU {datahora: datetime('2025-07-12T15:05:00')}]->(box),
       (ana)-[:COMPROU   {datahora: datetime('2025-07-12T16:00:00')}]->(wf),
       (ana)-[:COMPROU   {datahora: datetime('2025-07-12T16:00:00')}]->(box),
       (ana)-[:AVALIOU   {datahora: datetime('2025-07-14T10:00:00'), estrela: 4}]->(wf),
       (ana)-[:AVALIOU   {datahora: datetime('2025-07-14T10:05:00'), estrela: 4, comentario: 'Som potente!'}]->(box);

MATCH  (d:Cliente {nome: 'Diego'}),
       (watch:Produto {descricao: 'Smartwatch Samsung Galaxy Watch 4'}),
       (mon27:Produto {descricao: 'Monitor LG 27MP59G-P'})
CREATE (d)-[:VISUALIZOU {datahora: datetime('2025-07-13T09:00:00')}]->(watch),
       (d)-[:VISUALIZOU {datahora: datetime('2025-07-13T09:05:00')}]->(mon27),
       (d)-[:COMPROU   {datahora: datetime('2025-07-13T12:00:00')}]->(watch),
       (d)-[:COMPROU   {datahora: datetime('2025-07-13T12:00:00')}]->(mon27),
       (d)-[:AVALIOU   {datahora: datetime('2025-07-15T11:00:00'), estrela: 5}]->(watch),
       (d)-[:AVALIOU   {datahora: datetime('2025-07-15T11:05:00'), estrela: 4}]->(mon27);

MATCH (c:Cliente {nome: 'Carla'}), (p:Produto {descricao: 'Notebook Dell XPS 13'})
CREATE (c)-[:VISUALIZOU {datahora: datetime('2025-07-14T08:45:00')}]->(p),
       (c)-[:COMPROU   {datahora: datetime('2025-07-14T10:30:00')}]->(p),
       (c)-[:AVALIOU   {datahora: datetime('2025-07-15T14:15:00'), estrela: 5}]->(p);
