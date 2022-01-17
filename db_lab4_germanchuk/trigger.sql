-- перевіряє, чи сейли більше нуля
CREATE OR REPLACE FUNCTION check_negative()
    RETURNS TRIGGER AS
    $$
		BEGIN
			IF NEW.sales < 0
				THEN RAISE INFO 'Sales can''t be negative (your input: %).', NEW.sales;
				RETURN NULL;
			ELSE
				RETURN NEW;
			END IF;
		END
    $$
    LANGUAGE 'plpgsql';


-- тригер перед вставкою, щоб не дати вставити невірне значення
CREATE OR REPLACE TRIGGER check_negative
    BEFORE INSERT ON SaleInfo
    FOR EACH ROW EXECUTE FUNCTION check_negative();