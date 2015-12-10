module FakeTwilio
  # Minimal implementation to mimic sending of SMS messages.
  class Message
    attr_reader :to, :body, :success, :sent

    # Mimic processing a Message.
    def initialize(params)
      @success = verify_params(params)
      @to      = params['To']
      @body    = params['Body']
      @sent    = Time.now
    end

    # Produce output representing whether the SMS succeeded or failed.
    def to_json
      [status, price, date]
        .reduce(&:merge)
        .to_json
    end

    # Represent the date sent.  If the attempt to send an SMS failed, do not
    # list the date.
    def date
      success ? { 'datesent' => sent } : {}
    end

    private

    # Represent the state of the message.  Since no actual process exists,
    # constrain possible statuses to success or failure.
    def status
      { 'status' => success ? 'sent' : 'failed' }
    end

    # Represent the cost to send the message.  Possibilities are constrained to
    # 3 cents and nothing, predicated on success.
    def price
      { 'price' => success ? '0.03' : '0.00' }
    end

    # Implement minimal checking for the parameters.  The body must be between
    # 1 and 1600 bytes and a recipient must be specified.
    def verify_params(params)
      return false if params['Body'].to_s.empty?
      return false if params['Body'].to_s.bytes.size > 1600
      return false unless /\+\d+$/.match(params['To'])
      true
    end
  end
end
