require('pg')

class Property

  attr_reader :id
  attr_accessor :address, :value, :number_of_bedrooms, :year_built, :buy_let_status, :square_footage, :build_semi_flat_etc

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @year_built = options['year_built'].to_i
    @buy_let_status = options['buy_let_status']
    @square_footage = options['square_footage'].to_i
    @build_semi_flat_etc = options['build_semi_flat_etc']
  end

  def save
    db = PG.connect({dbname:'properties', host: 'localhost'})
    sql = "INSERT INTO property
    (address,
      value,
      number_of_bedrooms,
      year_built,
      buy_let_status,
      square_footage,
      build_semi_flat_etc)

      VALUES
      ($1, $2, $3, $4, $5, $6, $7)
      RETURNING *
      "
      values = [@address, @value, @number_of_bedrooms, @year_built, @buy_let_status, @square_footage, @build_semi_flat_etc]
      db.prepare('save', sql)
      @id = db.exec_prepared('save', values)[0]['id'].to_i
      db.close()
    end

    def Property.all
      db = PG.connect({dbname:'properties', host: 'localhost'})
      sql = "SELECT * FROM property"
      db.prepare('all', sql)
      check_properties = db.exec_prepared('all')
      db.close()
      return check_properties.map { |check_propertie| Property.new(check_propertie) }
    end

    def update
      db = PG.connect({dbname:'properties', host: 'localhost'})
      sql = "UPDATE property
      SET (address,
        value,
        number_of_bedrooms,
        year_built,
        buy_let_status,
        square_footage,
        build_semi_flat_etc) =

        ($1, $2, $3, $4, $5, $6, $7)
        WHERE id = $8"
        values = [@address, @value, @number_of_bedrooms, @year_built, @buy_let_status, @square_footage, @build_semi_flat_etc, @id]
        db.prepare('update', sql)
        db.exec_prepared('update', values)
        db.close()
      end

      def delete
        db = PG.connect({dbname:'properties', host: 'localhost'})
        sql = "DELETE FROM property
        WHERE id = $1"
        values = [@id]
        db.prepare('delete_one', sql)
        db.exec_prepared('delete_one', values)
        db.close
      end

      def Property.delete_all
        db = PG.connect({dbname:'properties', host: 'localhost'})
        sql = "DELETE FROM property"
        db.prepare('delete_all', sql)
        db.exec_prepared('delete_all')
        db.close
      end

    end
