# Tests made to increase the coverage.

io_err = Cint[0]

function coverage_increase(nlp :: CUTEstModel)
  pname = probname()
  vname = varnames(nlp.meta.nvar)
  if nlp.meta.ncon == 0
    pname, vname = unames(nlp.meta.nvar)
    calls, time = ureport()
    ureport!(calls, time)
  else
    pname, vname, cname = cnames(nlp.meta.nvar, nlp.meta.ncon)
    calls, time = creport()
    creport!(calls, time)
    cname = connames(nlp.meta.ncon)
    lchp = Int(cdimchp())
    cstats()
    chp_ind, chp_ptr = cchprodsp(nlp.meta.ncon, lchp)
    cchprodsp!(nlp.meta.ncon, lchp, chp_ind, chp_ptr)
    cchprodsp(io_err, Cint[nlp.meta.ncon], Cint[lchp], chp_ind, chp_ptr)
  end
end