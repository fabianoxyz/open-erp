class PrintedOrderItemsJob < BlingOrderItemCreatorBaseJob
  STATUS = BlingOrderItem::Status::PRINTED.freeze

  attr_accessor :account_id

  def perform(account_id)
    @status = STATUS
    @account_id = account_id
    orders = Services::Bling::Order.call(order_command: 'find_orders', tenant: account_id,
                                         situation: @status)
    orders = orders['data']

    create_orders(orders)
  end
end
