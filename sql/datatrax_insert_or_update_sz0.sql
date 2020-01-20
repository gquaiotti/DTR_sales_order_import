USE [TOTVS]
GO

/****** Object:  StoredProcedure [dbo].[datatrax_insert_or_update_sz0]    Script Date: 10/7/2019 10:38:00 AM ******/
DROP PROCEDURE [dbo].[datatrax_insert_or_update_sz0]
GO

/****** Object:  StoredProcedure [dbo].[datatrax_insert_or_update_sz0]    Script Date: 10/7/2019 10:38:00 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO









-- =============================================
-- Author:    QSdoBrasil
-- Create date: Jul 2019
-- Description: Load SZ0010 table with DATATRAX SALES ORDER info
-- =============================================
CREATE PROCEDURE [dbo].[datatrax_insert_or_update_sz0]
  -- Add the parameters for the stored procedure here
    @Z0_FILIAL  varchar(2),
    @Z0_STATUS  varchar(1),
    @Z0_XMLARQ  varchar(30),
    @Z0_CGC  varchar(14),
    @Z0_PESSOA  varchar(1),
    @Z0_NOME  varchar(40),
    @Z0_END  varchar(80),
    @Z0_EST  varchar(2),
    @Z0_COD_MUN  varchar(5),
    @Z0_MUN  varchar(60),
    @Z0_BAIRRO  varchar(40),
    @Z0_CEP  varchar(8),
    @Z0_COMPLEM  varchar(50),
    @Z0_EMAIL  varchar(50),
    @Z0_TEL  varchar(15),
    @Z0_ENDCOB  varchar(80),
    @Z0_ESTC  varchar(2),
    @Z0_MUNC  varchar(60),
    @Z0_CEPC  varchar(8),
    @Z0_P_DTTRA  varchar(10),
    @Z0_P_DTRAX  varchar(10),
    @Z0_EMISSAO  varchar(8),
    @Z0_CONDPAG  varchar(3),
    @Z0_TRANSP  varchar(6),
    @Z0_TPFRETE  varchar(1),
    @Z0_FRETE  float,
    @Z0_P_TRAN2  varchar(6),
    @Z0_P_FRET2  float,
    @Z0_P_TRAN3  varchar(6),
    @Z0_P_FRET3  float,
    @Z0_P_END  varchar(80),
    @Z0_P_EST  varchar(2),
    @Z0_P_CODMN  varchar(5),
    @Z0_P_BAIRR  varchar(40),
    @Z0_P_CEP  varchar(8),
    @Z0_P_COMPL  varchar(50),
    @Z0_P_WLDPA  varchar(15),
    @Z0_P_BAND  varchar(15),
    @Z0_P_TIPAG  varchar(5),
    @Z0_P_NSHIP  varchar(15),
    @Z0_P_TPPV  varchar(15),
    @Z0_DATA1  varchar(8),
    @Z0_PARC1  float,
    @Z0_P_TIPG1  varchar(15),
    @Z0_P_BAND1  varchar(15),
    @Z0_DATA2  varchar(8),
    @Z0_PARC2  float,
    @Z0_P_TIPG2  varchar(15),
    @Z0_P_BAND2  varchar(15),
    @Z0_DATA3  varchar(8),
    @Z0_PARC3  float,
    @Z0_P_TIPG3  varchar(15),
    @Z0_P_BAND3  varchar(15),
    @Z0_DATA4  varchar(8),
    @Z0_PARC4  float,
    @Z0_P_TIPG4  varchar(15),
    @Z0_P_BAND4  varchar(15),
    @Z0_DTENT  varchar(8),
    @Z0_HRENT  varchar(5),
    @Z0_P_AG  varchar(1),
  @Z0_DTXML  varchar(8),
    @Z0_HRXML  varchar(5)
AS
BEGIN
  -- SET NOCOUNT ON added to prevent extra result sets from
  -- interfering with SELECT statements.
  SET NOCOUNT ON;

  DECLARE @v_n_count INT

  -- Pedido ja importado ignora
  SELECT @v_n_count = ISNULL(COUNT(1), 0)
    FROM SZ0010 AS SZ0 WITH (NOLOCK)
   WHERE Z0_P_DTRAX = @Z0_P_DTRAX
     AND Z0_STATUS IN ('3', 'X')
     AND D_E_L_E_T_ <> '*'

  IF (@v_n_count = 0)
  BEGIN
    -- Procura pelo pedido na SZ0 mas ainda nao importado
    SELECT @v_n_count = ISNULL(COUNT(1), 0)
        FROM SZ0010 AS SZ0 WITH (NOLOCK)
       WHERE Z0_P_DTRAX = @Z0_P_DTRAX
         AND D_E_L_E_T_ <> '*'

    BEGIN TRANSACTION t_SZ0

    -- Se encontrar o pedido apaga o pedido e seus itens
    IF @v_n_count > 0
    BEGIN
      UPDATE SZ0010
         SET D_E_L_E_T_ = '*'
       WHERE Z0_P_DTRAX = @Z0_P_DTRAX
         AND D_E_L_E_T_ <> '*'

      UPDATE SZ1010
         SET D_E_L_E_T_ = '*'
       WHERE Z1_P_DTRAX = @Z0_P_DTRAX
         AND D_E_L_E_T_ <> '*'
    END

    INSERT INTO dbo.SZ0010
                 (Z0_FILIAL
                 ,Z0_STATUS
                 ,Z0_XMLARQ
                 ,Z0_CGC
                 ,Z0_PESSOA
                 ,Z0_NOME
                 ,Z0_END
                 ,Z0_EST
                 ,Z0_COD_MUN
                 ,Z0_MUN
                 ,Z0_BAIRRO
                 ,Z0_CEP
                 ,Z0_COMPLEM
                 ,Z0_EMAIL
                 ,Z0_TEL
                 ,Z0_ENDCOB
                 ,Z0_ESTC
                 ,Z0_MUNC
                 ,Z0_CEPC
                 ,Z0_P_DTTRA
                 ,Z0_P_DTRAX
                 ,Z0_EMISSAO
                 ,Z0_CONDPAG
                 ,Z0_TRANSP
                 ,Z0_TPFRETE
                 ,Z0_FRETE
                 ,Z0_P_TRAN2
                 ,Z0_P_FRET2
                 ,Z0_P_TRAN3
                 ,Z0_P_FRET3
                 ,Z0_P_END
                 ,Z0_P_EST
                 ,Z0_P_CODMN
                 ,Z0_P_BAIRR
                 ,Z0_P_CEP
                 ,Z0_P_COMPL
                 ,Z0_P_WLDPA
                 ,Z0_P_BAND
                 ,Z0_P_TIPAG
                 ,Z0_P_NSHIP
                 ,Z0_P_TPPV
                 ,Z0_DATA1
                 ,Z0_PARC1
                 ,Z0_P_TIPG1
                 ,Z0_P_BAND1
                 ,Z0_DATA2
                 ,Z0_PARC2
                 ,Z0_P_TIPG2
                 ,Z0_P_BAND2
                 ,Z0_DATA3
                 ,Z0_PARC3
                 ,Z0_P_TIPG3
                 ,Z0_P_BAND3
                 ,Z0_DATA4
                 ,Z0_PARC4
                 ,Z0_P_TIPG4
                 ,Z0_P_BAND4
                 ,R_E_C_N_O_
                 ,Z0_DTENT
                 ,Z0_HRENT
                 ,Z0_P_AG
           ,Z0_DTXML
           ,Z0_HRXML)
           VALUES
               (@Z0_FILIAL,
                @Z0_STATUS,
                @Z0_XMLARQ,
                @Z0_CGC,
                @Z0_PESSOA,
                @Z0_NOME,
                @Z0_END,
                @Z0_EST,
                @Z0_COD_MUN,
                @Z0_MUN,
                @Z0_BAIRRO,
                @Z0_CEP,
                @Z0_COMPLEM,
                @Z0_EMAIL,
                @Z0_TEL,
                @Z0_ENDCOB,
                @Z0_ESTC,
                @Z0_MUNC,
                @Z0_CEPC,
                @Z0_P_DTTRA,
                @Z0_P_DTRAX,
                @Z0_EMISSAO,
                @Z0_CONDPAG,
                @Z0_TRANSP,
                @Z0_TPFRETE,
                @Z0_FRETE,
                @Z0_P_TRAN2,
                @Z0_P_FRET2,
                @Z0_P_TRAN3,
                @Z0_P_FRET3,
                @Z0_P_END,
                @Z0_P_EST,
                @Z0_P_CODMN,
                @Z0_P_BAIRR,
                @Z0_P_CEP,
                @Z0_P_COMPL,
                @Z0_P_WLDPA,
                @Z0_P_BAND,
                @Z0_P_TIPAG,
                @Z0_P_NSHIP,
                @Z0_P_TPPV,
                @Z0_DATA1,
                @Z0_PARC1,
                @Z0_P_TIPG1,
                @Z0_P_BAND1,
                @Z0_DATA2,
                @Z0_PARC2,
                @Z0_P_TIPG2,
                @Z0_P_BAND2,
                @Z0_DATA3,
                @Z0_PARC3,
                @Z0_P_TIPG3,
                @Z0_P_BAND3,
                @Z0_DATA4,
                @Z0_PARC4,
                @Z0_P_TIPG4,
                @Z0_P_BAND4,
                (SELECT MAX(R_E_C_N_O_) + 1 FROM SZ0010),
                @Z0_DTENT,
                @Z0_HRENT,
                @Z0_P_AG,
          @Z0_DTXML,
          @Z0_HRXML)  

    COMMIT TRANSACTION t_SZ0

  END

  

  
   


  
END
GO

