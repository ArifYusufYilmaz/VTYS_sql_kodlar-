--
-- PostgreSQL database dump
--

-- Dumped from database version 12.0
-- Dumped by pg_dump version 12rc1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: guvenlikekle(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.guvenlikekle("guvenlikNo" integer, "vardiyaNo" integer, "personelId" integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into "public"."Guvenlik"("guvenlikNo" , "vardiyaNo" , "personelId"  )
    values ("guvenlikNo" , "vardiyaNo" , "personelId"  );
    return 'TAMAMLANDI';
    end;
    $$;


ALTER FUNCTION public.guvenlikekle("guvenlikNo" integer, "vardiyaNo" integer, "personelId" integer) OWNER TO postgres;

--
-- Name: guvenlikguncelle(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.guvenlikguncelle(guvenlikno integer, vardiyano integer, personelid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$	 DECLARE 
BEGIN
    UPDATE "public"."Guvenlik" SET "guvenlikNo" = guvenlikno, "vardiyaNo" = vardiyano where "personelId" = personelid;
	END; 	$$;


ALTER FUNCTION public.guvenlikguncelle(guvenlikno integer, vardiyano integer, personelid integer) OWNER TO postgres;

--
-- Name: izinekle(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.izinekle(izinid integer, ogrenciid integer, yoneticino integer) RETURNS void
    LANGUAGE plpgsql
    AS $$	 DECLARE 
BEGIN
    
insert into "public"."izin"("izinId","izinBaslangic","izinBitis","izinKullanim", "ogrenciId", "yoneticiNo")values (izinid,current_date,null,Null, ogrenciid,yoneticino);
	END; 	$$;


ALTER FUNCTION public.izinekle(izinid integer, ogrenciid integer, yoneticino integer) OWNER TO postgres;

--
-- Name: nevresimsil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.nevresimsil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	 
DECLARE 
BEGIN	
    DELETE From "nevresim" where "ogrenciId" = NEW."ogrenciId";
    return NEW;
    END; 	$$;


ALTER FUNCTION public.nevresimsil() OWNER TO postgres;

--
-- Name: odeucret(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.odeucret() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	 DECLARE 
BEGIN
     NEW."ucretDegeri" = NEW."ucretDegeri" - OLD."ucretDegeri";
     
   Return new;
	END; 	$$;


ALTER FUNCTION public.odeucret() OWNER TO postgres;

--
-- Name: ogrenciekle(integer, integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrenciekle(ogrenciid integer, kisiid integer, guvenlikid integer) RETURNS text
    LANGUAGE plpgsql
    AS $$	 DECLARE 
BEGIN	
    insert into "public"."Ogrenci"("ogrenciId","kayitTarihi","sonGirisTarihi","kisiId","guvenlikId") values (ogrenciid,CURRENT_DATE,CURRENT_DATE,kisiid,guvenlikid);
    return 'TAMAMLANDI';
    END; 	$$;


ALTER FUNCTION public.ogrenciekle(ogrenciid integer, kisiid integer, guvenlikid integer) OWNER TO postgres;

--
-- Name: ogrencisil(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrencisil(ogrenciid integer) RETURNS void
    LANGUAGE plpgsql
    AS $$	 DECLARE 
BEGIN
   delete from "public"."Ogrenci" where "ogrenciId"= ogrenciid;
    END; 	$$;


ALTER FUNCTION public.ogrencisil(ogrenciid integer) OWNER TO postgres;

--
-- Name: ogrgiris(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrgiris() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	 
DECLARE 
BEGIN	
    insert into public.nevresim("nevresimId","carsafNo","yorgankilifNo","yastikkilifNo","ogrenciId","temizlikciId") values (4,4,4,4,NEW."ogrenciId",1);
    insert into "public"."Barinma"("barinmaId","odaNo","yatakNo","dolapNo","ogrenciId") values(4,4,4,4,4);
    return NEW;
    END; 	$$;


ALTER FUNCTION public.ogrgiris() OWNER TO postgres;

--
-- Name: ogrsil(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ogrsil() RETURNS trigger
    LANGUAGE plpgsql
    AS $$	 
DECLARE 
BEGIN	
    DELETE From "nevresim" where "ogrenciId" = NEW."ogrenciId";
    DELETE From "Barinma" where "ogrenciId" = NEW."ogrenciId";
    return NEW;
    END; 	$$;


ALTER FUNCTION public.ogrsil() OWNER TO postgres;

--
-- Name: ucretode(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.ucretode(ucret integer, ogrenciid integer) RETURNS text
    LANGUAGE plpgsql
    AS $$	 DECLARE
 BEGIN	
 update public.ucret set "ucretDegeri" = ucret where "ogrenciId" = ogrenciid;
REturn 'TAMAMLANDI';
 END; 	$$;


ALTER FUNCTION public.ucretode(ucret integer, ogrenciid integer) OWNER TO postgres;

--
-- Name: updateyurt(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.updateyurt(yurtid integer, blokno integer) RETURNS void
    LANGUAGE plpgsql
    AS $$	
BEGIN
 
 UPDATE "public"."Yurt" SET "blokNo" = blokno 
  where "yurtId" = yurtid;
	END;
	$$;


ALTER FUNCTION public.updateyurt(yurtid integer, blokno integer) OWNER TO postgres;

--
-- Name: yurtekle(integer, integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yurtekle(yurtid integer, blokno integer) RETURNS text
    LANGUAGE plpgsql
    AS $$
BEGIN
    insert into "public"."Yurt"("yurtId","blokNo")
    values (yurtId, blokNo);
    return 'TAMAMLANDI';
    end;
    $$;


ALTER FUNCTION public.yurtekle(yurtid integer, blokno integer) OWNER TO postgres;

--
-- Name: yurtsil(integer); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.yurtsil(blokno integer) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN	
    DELETE From "Yurt" where "blokNo" = blokno;
    END; 	$$;


ALTER FUNCTION public.yurtsil(blokno integer) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Barinma; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Barinma" (
    "barinmaId" integer NOT NULL,
    "odaNo" integer NOT NULL,
    "yatakNo" integer NOT NULL,
    "dolapNo" integer NOT NULL,
    "ogrenciId" integer NOT NULL
);


ALTER TABLE public."Barinma" OWNER TO postgres;

--
-- Name: Guvenlik; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Guvenlik" (
    "guvenlikNo" integer NOT NULL,
    "vardiyaNo" integer NOT NULL,
    "personelId" integer NOT NULL
);


ALTER TABLE public."Guvenlik" OWNER TO postgres;

--
-- Name: Hesap; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Hesap" (
    "hesapId" integer NOT NULL,
    "kullaniciAdi" character varying(20) NOT NULL,
    sifre integer NOT NULL,
    "e-mail" text NOT NULL,
    "ogrenciId" integer NOT NULL,
    "yoneticiNo" integer NOT NULL
);


ALTER TABLE public."Hesap" OWNER TO postgres;

--
-- Name: Kisi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Kisi" (
    "kisiId" integer NOT NULL,
    "kisiSoyadi" character varying(50) NOT NULL,
    "kimlikNo" integer NOT NULL,
    "iletisimId" integer NOT NULL,
    "yurtId" integer NOT NULL,
    "kisiAdi" character varying(50) NOT NULL
);


ALTER TABLE public."Kisi" OWNER TO postgres;

--
-- Name: Ogrenci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Ogrenci" (
    "ogrenciId" integer NOT NULL,
    "kayitTarihi" date,
    "sonGirisTarihi" date,
    "kisiId" integer NOT NULL,
    "guvenlikId" integer NOT NULL
);


ALTER TABLE public."Ogrenci" OWNER TO postgres;

--
-- Name: Personel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Personel" (
    "personelId" integer NOT NULL,
    gorev text NOT NULL,
    "kisiId" integer NOT NULL,
    "sorumluOlduguBlok" integer NOT NULL
);


ALTER TABLE public."Personel" OWNER TO postgres;

--
-- Name: Temizlikci; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Temizlikci" (
    "temizlikciNo" integer NOT NULL,
    "yapilacakIs" character varying(2044) NOT NULL,
    "personelId" integer NOT NULL
);


ALTER TABLE public."Temizlikci" OWNER TO postgres;

--
-- Name: Yonetici; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yonetici" (
    "yoneticiNo" integer NOT NULL,
    yetki character varying(50) NOT NULL,
    "personelId" integer NOT NULL
);


ALTER TABLE public."Yonetici" OWNER TO postgres;

--
-- Name: Yurt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Yurt" (
    "yurtId" integer NOT NULL,
    "blokNo" integer NOT NULL
);


ALTER TABLE public."Yurt" OWNER TO postgres;

--
-- Name: iletisim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.iletisim (
    "iletisimId" integer NOT NULL,
    "telNo" integer NOT NULL,
    cinsiyet character varying(5) NOT NULL,
    "e-mail" text NOT NULL
);


ALTER TABLE public.iletisim OWNER TO postgres;

--
-- Name: izin; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.izin (
    "izinId" integer NOT NULL,
    "izinBaslangic" date,
    "izinBitis" date,
    "izinKullanim" integer,
    "ogrenciId" integer NOT NULL,
    "yoneticiNo" integer NOT NULL
);


ALTER TABLE public.izin OWNER TO postgres;

--
-- Name: nevresim; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nevresim (
    "nevresimId" integer NOT NULL,
    "carsafNo" integer NOT NULL,
    "yorgankilifNo" integer NOT NULL,
    "yastikkilifNo" integer NOT NULL,
    "ogrenciId" integer NOT NULL,
    "temizlikciId" integer NOT NULL
);


ALTER TABLE public.nevresim OWNER TO postgres;

--
-- Name: sosyalAktivite; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."sosyalAktivite" (
    "aktiviteId" integer NOT NULL,
    "aktiviteAdi" character varying(50) NOT NULL,
    "aktiviteSaati" time with time zone NOT NULL,
    "guvenlikId" integer NOT NULL,
    "ogrenciId" integer NOT NULL
);


ALTER TABLE public."sosyalAktivite" OWNER TO postgres;

--
-- Name: ucret; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ucret (
    "ucretId" integer NOT NULL,
    "ucretDegeri" integer NOT NULL,
    "sonOdemeTarihi" date,
    "ogrenciId" integer NOT NULL,
    "hesapId" integer NOT NULL,
    "ucretNo" integer NOT NULL
);


ALTER TABLE public.ucret OWNER TO postgres;

--
-- Name: yemek; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.yemek (
    "yemekId" integer NOT NULL,
    "yemekAdi" text,
    "kalanyemekHakki" integer NOT NULL,
    "ogrenciId" integer NOT NULL,
    "yemekTarih" date NOT NULL
);


ALTER TABLE public.yemek OWNER TO postgres;

--
-- Data for Name: Barinma; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: Guvenlik; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Guvenlik" VALUES (123123, 1, 21312);
INSERT INTO public."Guvenlik" VALUES (12313, 2, 1413);
INSERT INTO public."Guvenlik" VALUES (12321, 3, 23123);
INSERT INTO public."Guvenlik" VALUES (1231, 4, 4341);


--
-- Data for Name: Hesap; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Hesap" VALUES (1231, 'ada', 1, 'asdasd', 1232, 12312);
INSERT INTO public."Hesap" VALUES (123, 'adasd', 2, 'asda', 1231, 12321);
INSERT INTO public."Hesap" VALUES (1232, 'asdasd', 3, 'sadas', 123, 2321);


--
-- Data for Name: Kisi; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Kisi" VALUES (12321, 'alaybeyoglu', 1232, 213123, 231, 'yusuf');
INSERT INTO public."Kisi" VALUES (123, 'yilmaz', 12, 12312, 2311, 'zeliha');
INSERT INTO public."Kisi" VALUES (12312, 'yarimoglu', 123, 3423, 12321, 'yasin');
INSERT INTO public."Kisi" VALUES (1231, 'yilmaz', 12323, 1231, 321, 'yasemin');


--
-- Data for Name: Ogrenci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Ogrenci" VALUES (1232, NULL, NULL, 12321, 123123);
INSERT INTO public."Ogrenci" VALUES (1231, NULL, NULL, 123, 12313);
INSERT INTO public."Ogrenci" VALUES (123, NULL, NULL, 12312, 12321);


--
-- Data for Name: Personel; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Personel" VALUES (21312, 'adsad', 12321, 1);
INSERT INTO public."Personel" VALUES (4341, 'adsasd', 1231, 4);
INSERT INTO public."Personel" VALUES (23123, 'adad', 12312, 3);
INSERT INTO public."Personel" VALUES (1413, 'sadad', 123, 2);


--
-- Data for Name: Temizlikci; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Temizlikci" VALUES (12312, 'adasd', 21312);
INSERT INTO public."Temizlikci" VALUES (1231, 'adasd', 4341);
INSERT INTO public."Temizlikci" VALUES (213123, 'adsas', 23123);
INSERT INTO public."Temizlikci" VALUES (12321, 'asdasd', 1413);


--
-- Data for Name: Yonetici; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yonetici" VALUES (12312, 'asdas', 21312);
INSERT INTO public."Yonetici" VALUES (231, 'adasd', 4341);
INSERT INTO public."Yonetici" VALUES (2321, 'sadasd', 23123);
INSERT INTO public."Yonetici" VALUES (12321, 'sdad', 1413);


--
-- Data for Name: Yurt; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public."Yurt" VALUES (321, 2);
INSERT INTO public."Yurt" VALUES (12321, 3);
INSERT INTO public."Yurt" VALUES (2311, 4);
INSERT INTO public."Yurt" VALUES (231, 3);
INSERT INTO public."Yurt" VALUES (1232, 5);


--
-- Data for Name: iletisim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.iletisim VALUES (213123, 540, 'e', 'ex@gmail.com');
INSERT INTO public.iletisim VALUES (12312, 541, 'e', 'ex2@gmail.com');
INSERT INTO public.iletisim VALUES (3423, 542, 'e', 'ex3@gmail.com');
INSERT INTO public.iletisim VALUES (1231, 543, 'e', 'ex4@gmail.com');
INSERT INTO public.iletisim VALUES (341123, 133, 'e', 'ex4@gmail.com');


--
-- Data for Name: izin; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.izin VALUES (1323, NULL, NULL, NULL, 1232, 12312);
INSERT INTO public.izin VALUES (1321, NULL, NULL, NULL, 1231, 12321);


--
-- Data for Name: nevresim; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.nevresim VALUES (123, 1, 1, 1, 1232, 12312);
INSERT INTO public.nevresim VALUES (1313, 2, 2, 2, 1231, 12321);
INSERT INTO public.nevresim VALUES (21312, 3, 3, 3, 123, 213123);


--
-- Data for Name: sosyalAktivite; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Data for Name: ucret; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.ucret VALUES (134, 280, NULL, 1231, 123, 2);
INSERT INTO public.ucret VALUES (123, 280, NULL, 1232, 1231, 1);


--
-- Data for Name: yemek; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- Name: Barinma Barinma_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Barinma"
    ADD CONSTRAINT "Barinma_pkey" PRIMARY KEY ("barinmaId");


--
-- Name: Personel Personel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "Personel_pkey" PRIMARY KEY ("personelId");


--
-- Name: Temizlikci Temizlikci_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Temizlikci"
    ADD CONSTRAINT "Temizlikci_pkey" PRIMARY KEY ("temizlikciNo");


--
-- Name: Yonetici Yonetici_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "Yonetici_pkey" PRIMARY KEY ("yoneticiNo");


--
-- Name: Yurt Yurt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yurt"
    ADD CONSTRAINT "Yurt_pkey" PRIMARY KEY ("yurtId");


--
-- Name: iletisim iletisim_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.iletisim
    ADD CONSTRAINT iletisim_pkey PRIMARY KEY ("iletisimId");


--
-- Name: ucret ucret_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucret
    ADD CONSTRAINT ucret_pkey PRIMARY KEY ("ucretId");


--
-- Name: Barinma unique_Barinma_barinmaId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Barinma"
    ADD CONSTRAINT "unique_Barinma_barinmaId" UNIQUE ("barinmaId");


--
-- Name: Guvenlik unique_Guvenlik_guvenlikNo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Guvenlik"
    ADD CONSTRAINT "unique_Guvenlik_guvenlikNo" PRIMARY KEY ("guvenlikNo");


--
-- Name: Guvenlik unique_Guvenlik_personelId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Guvenlik"
    ADD CONSTRAINT "unique_Guvenlik_personelId" UNIQUE ("personelId");


--
-- Name: Hesap unique_Hesap_hesapId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hesap"
    ADD CONSTRAINT "unique_Hesap_hesapId" PRIMARY KEY ("hesapId");


--
-- Name: Hesap unique_Hesap_ogrenciId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hesap"
    ADD CONSTRAINT "unique_Hesap_ogrenciId" UNIQUE ("ogrenciId");


--
-- Name: Kisi unique_Kisi_kisiId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "unique_Kisi_kisiId" PRIMARY KEY ("kisiId");


--
-- Name: Ogrenci unique_Ogrenci_kisiId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "unique_Ogrenci_kisiId" UNIQUE ("kisiId");


--
-- Name: Ogrenci unique_Ogrenci_ogrenciId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "unique_Ogrenci_ogrenciId" PRIMARY KEY ("ogrenciId");


--
-- Name: Personel unique_Personel_kisiId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "unique_Personel_kisiId" UNIQUE ("kisiId");


--
-- Name: Temizlikci unique_Temizlikci_personelId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Temizlikci"
    ADD CONSTRAINT "unique_Temizlikci_personelId" UNIQUE ("personelId");


--
-- Name: Yonetici unique_Yonetici_personelId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "unique_Yonetici_personelId" UNIQUE ("personelId");


--
-- Name: Yurt unique_Yurt_yurtId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yurt"
    ADD CONSTRAINT "unique_Yurt_yurtId" UNIQUE ("yurtId");


--
-- Name: izin unique_izin_izinId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.izin
    ADD CONSTRAINT "unique_izin_izinId" PRIMARY KEY ("izinId");


--
-- Name: nevresim unique_nevresim_nevresimId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nevresim
    ADD CONSTRAINT "unique_nevresim_nevresimId" PRIMARY KEY ("nevresimId");


--
-- Name: sosyalAktivite unique_sosyalAktivite_aktiviteId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."sosyalAktivite"
    ADD CONSTRAINT "unique_sosyalAktivite_aktiviteId" PRIMARY KEY ("aktiviteId");


--
-- Name: sosyalAktivite unique_sosyalAktivite_guvenlikId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."sosyalAktivite"
    ADD CONSTRAINT "unique_sosyalAktivite_guvenlikId" UNIQUE ("guvenlikId");


--
-- Name: sosyalAktivite unique_sosyalAktivite_ogrenciId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."sosyalAktivite"
    ADD CONSTRAINT "unique_sosyalAktivite_ogrenciId" UNIQUE ("ogrenciId");


--
-- Name: ucret unique_ucret_hesapId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucret
    ADD CONSTRAINT "unique_ucret_hesapId" UNIQUE ("hesapId");


--
-- Name: ucret unique_ucret_ucretId; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucret
    ADD CONSTRAINT "unique_ucret_ucretId" UNIQUE ("ucretId");


--
-- Name: yemek yemek_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yemek
    ADD CONSTRAINT yemek_pkey PRIMARY KEY ("yemekId");


--
-- Name: index_iletisimId; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "index_iletisimId" ON public.iletisim USING btree ("iletisimId");


--
-- Name: izin nevresimsil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER nevresimsil AFTER INSERT ON public.izin FOR EACH ROW EXECUTE FUNCTION public.nevresimsil();


--
-- Name: ucret odeme; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER odeme BEFORE UPDATE ON public.ucret FOR EACH ROW EXECUTE FUNCTION public.odeucret();


--
-- Name: Ogrenci ogrencigiris; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ogrencigiris AFTER INSERT ON public."Ogrenci" FOR EACH ROW EXECUTE FUNCTION public.ogrgiris();


--
-- Name: Ogrenci ogrencisil; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER ogrencisil AFTER DELETE ON public."Ogrenci" FOR EACH ROW EXECUTE FUNCTION public.ogrsil();


--
-- Name: Ogrenci lnk_Guvenlik_Ogrenci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "lnk_Guvenlik_Ogrenci" FOREIGN KEY ("guvenlikId") REFERENCES public."Guvenlik"("guvenlikNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sosyalAktivite lnk_Guvenlik_sosyalAktivite; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."sosyalAktivite"
    ADD CONSTRAINT "lnk_Guvenlik_sosyalAktivite" FOREIGN KEY ("guvenlikId") REFERENCES public."Guvenlik"("guvenlikNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ucret lnk_Hesap_ucret; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucret
    ADD CONSTRAINT "lnk_Hesap_ucret" FOREIGN KEY ("hesapId") REFERENCES public."Hesap"("hesapId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Ogrenci lnk_Kisi_Ogrenci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Ogrenci"
    ADD CONSTRAINT "lnk_Kisi_Ogrenci" FOREIGN KEY ("kisiId") REFERENCES public."Kisi"("kisiId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Personel lnk_Kisi_Personel; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Personel"
    ADD CONSTRAINT "lnk_Kisi_Personel" FOREIGN KEY ("kisiId") REFERENCES public."Kisi"("kisiId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Barinma lnk_Ogrenci_Barinma; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Barinma"
    ADD CONSTRAINT "lnk_Ogrenci_Barinma" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Hesap lnk_Ogrenci_Hesap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hesap"
    ADD CONSTRAINT "lnk_Ogrenci_Hesap" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: izin lnk_Ogrenci_izin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.izin
    ADD CONSTRAINT "lnk_Ogrenci_izin" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nevresim lnk_Ogrenci_nevresim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nevresim
    ADD CONSTRAINT "lnk_Ogrenci_nevresim" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: sosyalAktivite lnk_Ogrenci_sosyalAktivite; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."sosyalAktivite"
    ADD CONSTRAINT "lnk_Ogrenci_sosyalAktivite" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: ucret lnk_Ogrenci_ucret; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ucret
    ADD CONSTRAINT "lnk_Ogrenci_ucret" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: yemek lnk_Ogrenci_yemek; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.yemek
    ADD CONSTRAINT "lnk_Ogrenci_yemek" FOREIGN KEY ("ogrenciId") REFERENCES public."Ogrenci"("ogrenciId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Guvenlik lnk_Personel_Guvenlik; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Guvenlik"
    ADD CONSTRAINT "lnk_Personel_Guvenlik" FOREIGN KEY ("personelId") REFERENCES public."Personel"("personelId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Temizlikci lnk_Personel_Temizlikci; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Temizlikci"
    ADD CONSTRAINT "lnk_Personel_Temizlikci" FOREIGN KEY ("personelId") REFERENCES public."Personel"("personelId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Yonetici lnk_Personel_Yonetici; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Yonetici"
    ADD CONSTRAINT "lnk_Personel_Yonetici" FOREIGN KEY ("personelId") REFERENCES public."Personel"("personelId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: nevresim lnk_Temizlikci_nevresim; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nevresim
    ADD CONSTRAINT "lnk_Temizlikci_nevresim" FOREIGN KEY ("temizlikciId") REFERENCES public."Temizlikci"("temizlikciNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Hesap lnk_Yonetici_Hesap; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Hesap"
    ADD CONSTRAINT "lnk_Yonetici_Hesap" FOREIGN KEY ("yoneticiNo") REFERENCES public."Yonetici"("yoneticiNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: izin lnk_Yonetici_izin; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.izin
    ADD CONSTRAINT "lnk_Yonetici_izin" FOREIGN KEY ("yoneticiNo") REFERENCES public."Yonetici"("yoneticiNo") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kisi lnk_Yurt_Kisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "lnk_Yurt_Kisi" FOREIGN KEY ("yurtId") REFERENCES public."Yurt"("yurtId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: Kisi lnk_iletisim_Kisi; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Kisi"
    ADD CONSTRAINT "lnk_iletisim_Kisi" FOREIGN KEY ("iletisimId") REFERENCES public.iletisim("iletisimId") MATCH FULL ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

