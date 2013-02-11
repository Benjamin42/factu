class CleaningVillesController < ApplicationController
  # GET /cleaning_villes
  # GET /cleaning_villes.json
  def index

    respond_to do |format|
      format.html
      format.json { render json: VillesCleaningDatatable.new(view_context) }
    end
  end

  def uploadFile
    @token = :cleaning
    file_data = params[:my_file]
    errs = []

    if file_data.respond_to?(:read)
      csv_contents = file_data.read
    elsif file_data.respond_to?(:path)
      csv_contents = File.read(file_data.path)
    else
      logger.error "Bad file_data: #{file_data.class.name}: #{file_data.inspect}"
    end

    CSV.parse(csv_contents, {:headers => true, :col_sep => ";", :quote_char => '"'}) do |row|
      ville = CleaningVille.build_from_csv(row)
      # Save upon valid
      # otherwise collect error records to export
      if ville.valid?
        ville.save
      else
        errs << row
      end
    end

    File.open(Rails.root.join('public', 'uploads', "#{Date.today.strftime('%d%m%y')}_" + file_data.original_filename), 'w') do |file|
      file.write(file_data.read)
    end

    # Export Error file for later upload upon correction
    if errs.any?
      flash[:error] = "File has been uploaded with errors."
    else
    #I18n.t('customer.import.success')
      flash[:notice] = "File has been uploaded successfully"
    end

    redirect_to "/cleaning_villes"
  end  
end
