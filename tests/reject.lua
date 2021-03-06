describe('reject', function()
  it('uses the identity function as the predicate if none is specified', function()
    local observable = Rx.Observable.fromTable({false, true}):reject()
    expect(observable).to.produce(false)
  end)

  it('passes all arguments to the predicate', function()
    local predicate = spy()
    Rx.Observable.fromTable({{1, 2}, {3, 4, 5}}, ipairs):unpack():reject(predicate):subscribe()
    expect(predicate).to.equal({{1, 2}, {3, 4, 5}})
  end)

  it('does not produce elements that the predicate returns true for', function()
    local predicate = function(x) return x % 2 == 0 end
    local observable = Rx.Observable.fromRange(1, 5):reject(predicate)
    expect(observable).to.produce(1, 3, 5)
  end)

  it('errors when its parent errors', function()
    local observable = Rx.Observable.fromValue(''):map(function(x) return x() end)
    expect(observable.subscribe).to.fail()
    expect(observable:reject().subscribe).to.fail()
  end)
end)
