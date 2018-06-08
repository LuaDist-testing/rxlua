describe('pack', function()
  it('produces an error if its parent errors', function()
    local observable = Rx.Observable.fromValue(''):map(function(x) return x() end)
    expect(observable.subscribe).to.fail()
    expect(observable:pack().subscribe).to.fail()
  end)

  it('wraps elements of the source in tables', function()
    local observable = Rx.Observable.fromTable({4, 5, 6}, ipairs, true):pack()
    expect(observable).to.produce({{{4, 1}}, {{5, 2}}, {{6, 3}}})
  end)
end)
