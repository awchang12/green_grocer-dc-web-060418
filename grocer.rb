def consolidate_cart(cart)
  # code here
  consolidated_cart = {}
  
  cart.each do |item_hash|
    item_hash.each do |item, item_values|
      if !consolidated_cart[item]
        consolidated_cart[item] = item_values
        consolidated_cart[item][:count] = 1
      else
        consolidated_cart[item][:count] += 1
      end
    end
  end
  consolidated_cart
end

def apply_coupons(cart, coupons)
  # code here
  coupon_cart = cart
  if coupons.length == 0
    coupon_cart
  end
  
  coupons.each do |coupon|
    name = coupon[:item]
    if coupon_cart.has_key?(name) && coupon_cart[name][:count] >= coupon[:num]
      coupon_cart[name][:count] -= coupon[:num]
      new_key = "#{name} W/COUPON"
      if coupon_cart.has_key?(new_key)
        coupon_cart[new_key][:count] += 1
      else
        coupon_cart[new_key] = {
          :price => coupon[:cost],
          :clearance => coupon_cart[name][:clearance],
          :count => 1
        }
      end
    end
  end
  coupon_cart
end

def apply_clearance(cart)
  # code here
  cart.each do |item, values|
    if cart[item][:clearance]
      cart[item][:price] = cart[item][:price] * 4/5
    end
  end
end

def checkout(cart, coupons)
  # code here
  consolidated_cart = consolidate_cart(cart)
  coupon_cart = apply_coupons(consolidated_cart, coupons)
  clearance_cart = apply_clearance(coupon_cart)
  
  total = 0
  
  clearance_cart.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  
  if total > 100
    total = total * 9/10
  end
  total
end
