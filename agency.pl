% ------------------
%|      FATOS       |
% ------------------

% voo(cod_voo, origem, destino, preco, tempo_min) 

voo(v001,rio_de_janeiro,sao_paulo,150,52).
voo(v002,sao_paulo,florianopolis,200,30).
voo(v003,florianopolis,juiz_de_fora,200,30).
voo(v004,florianopolis,sao_paulo,200,30).
voo(v005,pato_branco,juiz_de_fora,50,30).
voo(v006,florianopolis,pato_branco,50,30).
voo(v007,sao_paulo,rio_de_janeiro,1000,45).
voo(v008,sao_paulo,frankfurt,2000,600).
voo(v009,sao_paulo,hannover,1500,660).
voo(v010,rio_de_janeiro,berlin,2000,45).
voo(v011,frankfurt,marburg,30,20).
voo(v012,frankfurt,madrid,200,120).
voo(v013,frankfurt,paris,120,30).
voo(v014,paris,madrid,130,120).
voo(v015,new_york,florianopolis,3500,700).
voo(v016,berlin,madrid,350,180).
voo(v017,madrid,paris,300,120).
voo(v018,paris,frankfurt,600,60).
voo(v019,marburg,hannover,200,30).
voo(v020,rio_de_janeiro,pato_branco,2000,120).
voo(v021,berlin,madrid,250,65).
voo(v022,berlin,new_york,3000,540).
voo(v023,new_york,buenos_aires,4000,500).
voo(v024,buenos_aires,sao_paulo,1200,100).
voo(v025,buenos_aires,berlim,3600,750).
voo(v026,buenos_aires,madrid,2300,2600).
voo(v027,madrid,pato_branco,3000,1200).
voo(v028,frankfurt,sao_paulo,2000,600).
voo(v029,hannover,frankfurt,100,40).
voo(v030,juiz_de_fora,sao_paulo,80,30).
voo(v031,buenos_aires,new_york,200,500).
voo(v032,sao_paulo,buenos_aires,400,120).

% cidade(cod_cidade, nome, pais)

cidade(c001,rio_de_janeiro,p001).
cidade(c002,sao_paulo,p001).
cidade(c003,florianopolis,p001).
cidade(c004,juiz_de_fora,p001).
cidade(c005,pato_branco,p001).
cidade(c006,buenos_aires,p002).
cidade(c007,new_york,p003).
cidade(c008,frankfurt,p004).
cidade(c009,marburg,p004).
cidade(c010,hannover,p004).
cidade(c011,berlin,p004).
cidade(c012,paris,p005).
cidade(c013,madrid,p006).


% Pais (cod_pais, nome, moeda)

pais(p001, brasil, brl).
pais(p002, argentina, ars).
pais(p003, estados_unidos, usd).
pais(p004, alemanha, eur).
pais(p005, franca, eur).
pais(p006, espanha, eur).


% Moeda (cod_moeda, nome, conversao)

moeda(brl, real, 1).
moeda(ars, peso_argentino, 0.55).
moeda(eur, euro, 4.5).
moeda(usd, dolar_americano, 4).

% Hotel (cod_hotel, nome, cidade, estrelas, preco_diaria)

hotel(h001,plaza_Rio,c001,'****',100).
hotel(h002,plaza_Sampa,c002,'***',120).
hotel(h003,plaza_Floripa,c003,'*****',1000).
hotel(h004,plaza_JF,c004,'***',220).
hotel(h005,plaza_JF3,c004,'***',40).
hotel(h006,plaza_PATO,c005,'***',80).
hotel(h007,hilton,c006,'***',1180).
hotel(h008,mercury,c007,'***',180).
hotel(h009,ibis_rich,c008,'***',80).
hotel(h010,ibis_budget,c009,'***',15).
hotel(h011,carlton,c0010,'***',110).
hotel(h012,linden,c011,'***',180).
hotel(h013,uova,c012,'***',130).
hotel(h014,salsalito,c013,'***',180).

% ------------------
%|      REGRAS      |
% ------------------

% Regra de voo

viagem(X,Y, Cod_cidades_inicial, Cod_cidades_final, Cod_voos, Cod_voos_final,Custo,Total_aereo) :- voo(Cod_voo,X,Y,Preco, _), % Busca se existe algum voo direto
	cidade(Cod2, Y,_), % Buscar o codigo da cidade destino
	not(member(Cod2,Cod_cidades_inicial)),            % A cidade destino ja se encontra na lista de conexoes?
	append(Cod_cidades_inicial,[Cod2],Cod_cidades_final),   % Acrescenta no vetor cidade destino
	append(Cod_voos,[Cod_voo],Cod_voos_final),
    Total_aereo is Custo+Preco.   % Acrescenta o voo na lista de voos escolhidos


viagem(X,Y, Cod_cidades_inicial, Cod_cidades_final, Cod_voos, Cod_voos_final, Custo,Total_aereo) :- voo(Cod_voo,X,Z,Preco, _),         % Busca uma conexao
	cidade(Cod2, Z,_),   % Buscar o codigo da cidade destino
	not(member(Cod2,Cod_cidades_inicial)), % A cidade destino ja se encontra na lista de conexoes?
	append(Cod_cidades_inicial,[Cod2],Cod_cidades_final1),                                              % Acrescenta no vetor cidade destino
	append(Cod_voos,[Cod_voo],Cod_voos_1),
    Parcial is Custo+Preco,   % Acrescenta o voo na lista de voos escolhidos
	viagem(Z,Y, Cod_cidades_final1, Cod_cidades_final, Cod_voos_1, Cod_voos_final,Parcial,Total_aereo). % Recursividade para buscar nova conexao

    
imprimir_voos_linha(Cod_voos,Cod_voos_Original,Total_aereo) :- Cod_voos = [Cod|Lista1],
    voo(Cod,X,Y,Custo,_),
    append([X],[Y],Cidades),
    imprimir_voos_linha(Lista1,Cod_voos_Original, Cidades,Custo,Total_aereo).

imprimir_voos_linha(Cod_voos,Cod_voos_Original,Custo) :- Cod_voos = [Cod|[]],
    voo(Cod,X,Y,Custo,_),
    append([X],[Y],Cidades),
    write(Custo),write('\t'),write(Cod_voos_Original), write('\t\t'),write(Cidades),write('\n').

imprimir_voos_linha(Cod_voos,Cod_voos_Original, Cidades,Custo,Total_aereo) :- Cod_voos = [Cod|Lista1],
    voo(Cod,_,Y,Custo2,_),
    append(Cidades,[Y],Cidades2),
    Total is Custo+Custo2,
    imprimir_voos_linha(Lista1,Cod_voos_Original, Cidades2,Total,Total_aereo).

imprimir_voos_linha(Cod_voos,Cod_voos_Original, Cidades,Custo,Total) :- Cod_voos = [Cod|[]],
    voo(Cod,_,Y,Custo2,_),
    append(Cidades,[Y],Cidades2),
    Total is Custo+Custo2,
    write(Total),write('\t'),write(Cod_voos_Original) ,write('\t\t'),write(Cidades2),write('\n').


busca_voos(X,Y,Cod1,Cod_voos_final,Total_aereo) :-  viagem(X,Y,[Cod1],Cod_cidades_final,[], Cod_voos_final,0,Total_aereo).

imprime_voo(Cod_voos_final) :- write('\nVoos\nPreco\tCodigos\t\t\t\tCidades\n'), 
    imprimir_voos_linha(Cod_voos_final,Cod_voos_final,O).


%Regras relacionando cidades, paises e moedas
cod_cidade_cod_pais(Cod_pais,Cod_cidade) :- cidade(Cod_cidade,_,Cod_pais).

cod_cidade_pais(Pais,Cod_cidade) :- cod_cidade_cod_pais(Cod_pais,Cod_cidade), 
    pais(Cod_pais,Pais,_).
cidade_cod_pais(Cod_pais,Cidades) :- cidade(_,Cidades,Cod_pais).

cidade_pais(Pais,Cidade) :- cidade(_,Cidade,Cod_pais),pais(Cod_pais,Pais,_).

cod_pais_cod_moeda(Cod_moeda,Cod_pais) :- pais(Cod_pais,_,Cod_moeda).

cod_pais_moeda(Moeda,Cod_pais) :- cod_pais_cod_moeda(Cod_moeda,Cod_pais),
    moeda(Cod_moeda,Moeda,_).

pais_moeda(Moeda,Pais) :- pais(_,Pais,Cod_moeda),
    moeda(Cod_moeda,Moeda,_).

cod_cidade_cod_moeda(Cod_moeda,Cod_cidade) :- cod_cidade_cod_pais(Cod_pais,Cod_cidade), 
    cod_pais_cod_moeda(Cod_moeda,Cod_pais).

cod_cidade_moeda(Moeda,Cod_cidade) :- cidade(Cod_cidade,_,Cod_pais), 
    moeda(Cod_moeda,Moeda,_),pais(Cod_pais,_,Cod_moeda).

busca_hotel(Cod_cidade,Diarias,Cod_hotel,Total_hotel,Cod_moeda) :- hotel(Cod_hotel,_,Cod_cidade,_,Custo),
    cod_cidade_cod_moeda(Cod_moeda,Cod_cidade),
    moeda(Cod_moeda,_,Cotacao),
    Total_hotel is Diarias*Custo*Cotacao.

imprime_hotel(Cod_hotel,Diarias,Total_hotel,Cod_moeda) :- hotel(Cod_hotel,Nome,_,Estrelas,Custo),
    moeda(Cod_moeda,_,Cotacao),
    write('\nHoteis\nCodigo\tNome\t\t\tEstrelas   Diarias   Preco ('),write(Cod_moeda),write(')   Total ('),write(Cod_moeda),write(')   Total (brl)\n'),
    Total_local is Custo*Diarias,
    write(Cod_hotel),write('\t'),write(Nome), write('\t\t'),write(Estrelas),write('\t   '),write(Diarias),write('\t     '),write(Custo),write('\t\t'), write(Total_local),write('\t      '),write(Total_hotel),write('\n').


% Regra que busca um destino
pacote(X,Y,Diarias,Max_voos) :- cidade(Cod1, X,_),	
    cidade(Cod2, Y,_),
    Cod1 \== Cod2,
    busca_voos(X,Y,Cod1,Cod_voos_final_ida,Total_aereo_ida),
    busca_voos(Y,X,Cod2,Cod_voos_final_volta,Total_aereo_volta),
    busca_hotel(Cod2,Diarias,Cod_hotel,Total_hotel,Cod_moeda),
    length(Cod_voos_final_ida,Limite1),
    length(Cod_voos_final_volta,Limite2),
    Limite1 =< Max_voos,
    Limite2 =< Max_voos,
    Total is Total_aereo_ida+Total_aereo_volta+Total_hotel,
    imprime_voo(Cod_voos_final_ida),
    imprime_voo(Cod_voos_final_volta),
    imprime_hotel(Cod_hotel,Diarias,Total_hotel,Cod_moeda),
    write('\nTOTAL: '),write(Total).

% Regra que busca um destino de acordo com sua moeda.
pacote_moeda(X,Moeda,Diarias,Max_voos) :- cod_cidade_moeda(Moeda,Cod),
    cidade(Cod,Y,_),
    pacote(X,Y,Diarias,Max_voos).

% Regra que busca um destino no pais desejado.
pacote_pais(X,Pais,Diarias,Max_voos) :- cod_cidade_pais(Pais,Cod),
    cidade(Cod,Y,_),
    pacote(X,Y,Diarias,Max_voos).

% Regra que busca a partir do preco maximo um destino com hospedagem.
pacote_preco(X,Preco,Diarias,Max_voos) :- cidade(Cod1, X,_),	
    cidade(Cod2, Y,_),
    Cod1 \== Cod2,
    busca_voos(X,Y,Cod1,Cod_voos_final_ida,Total_aereo_ida),
    busca_voos(Y,X,Cod2,Cod_voos_final_volta,Total_aereo_volta),
    length(Cod_voos_final_ida,Limite1),
    length(Cod_voos_final_volta,Limite2),
    Limite1 =< Max_voos,
    Limite2 =< Max_voos,
    busca_hotel(Cod2,Diarias,Cod_hotel,Total_hotel,Cod_moeda),
    Total is Total_aereo_ida+Total_aereo_volta+Total_hotel,
    Total < Preco,
    imprime_voo(Cod_voos_final_ida),
    imprime_voo(Cod_voos_final_volta),
    imprime_hotel(Cod_hotel,Diarias,Total_hotel,Cod_moeda),
    write('\nTOTAL: '),write(Total).

%EXEMPLO DE CONSULTAS
% pacote(sao_paulo,X,10,3).
% pacote_preco(florianopolis,3000,1,3).
% pacote_pais(sao_paulo,alemanha,10,3).
% pacote_moeda(sao_paulo,euro,10,3).
