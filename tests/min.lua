describe('min', function()
  it('produces an error if its parent errors', function()
    local observable = Rx.Observable.fromValue(''):map(function(x) return x() end)
    expect(observable.subscribe).to.fail()
    expect(observable:min().subscribe).to.fail()
  end)

  it('produces an error if one of the values produced is a string', function()
    local observable = Rx.Observable.fromValue('string'):min()
    expect(observable.subscribe).to.fail()
  end)

  it('produces the minimum of all values produced', function()
    local observable = Rx.Observable.fromRange(5):min()
    expect(observable).to.produce(1)
  end)
end)
