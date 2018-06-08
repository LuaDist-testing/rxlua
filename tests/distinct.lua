describe('distinct', function()
  it('does not produce the same value twice', function()
    local observable = Rx.Observable.fromTable({1, 1, 2, 1, 3, 3, 2, 1, 4}, ipairs):distinct()
    expect(observable).to.produce(1, 2, 3, 4)
  end)

  it('produces an error if its parent errors', function()
    local observable = Rx.Observable.fromValue(''):map(function(x) return x() end)
    expect(observable.subscribe).to.fail()
    expect(observable:distinct().subscribe).to.fail()
  end)

  it('completes when its parent completes', function()
    local subject = Rx.Subject.create()
    local onCompleted = spy()
    subject:distinct():subscribe(nil, nil, onCompleted)
    expect(#onCompleted).to.equal(0)
    subject:onCompleted()
    expect(#onCompleted).to.equal(1)
  end)
end)
