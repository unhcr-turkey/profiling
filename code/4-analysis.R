# Rattle is Copyright (c) 2006-2015 Togaware Pty Ltd.

#============================================================
# Rattle timestamp: 2016-01-16 18:03:40 x86_64-w64-mingw32 

# Rattle version 4.0.5 user 'legoupil'

# This log file captures all Rattle interactions as R commands. 

Export this log to a file using the Export button or the Tools 
# menu to save a log of all your activity. This facilitates repeatability. For example, exporting 
# to a file called 'myrf01.R' will allow you to type in the R Console 
# the command source('myrf01.R') and so repeat all actions automatically. 
# Generally, you will want to edit the file to suit your needs. You can also directly 
# edit this current log in place to record additional information before exporting. 
 
# Saving and loading projects also retains this log.

# We begin by loading the required libraries.

library(rattle)   # To access the weather dataset and utility commands.
library(magrittr) # For the %>% and %<>% operators.

# This log generally records the process of building a model. However, with very 
# little effort the log can be used to score a new dataset. The logical variable 
# 'building' is used to toggle between generating transformations, as when building 
# a model, and simply using the transformations, as when scoring a dataset.

building <- TRUE
scoring  <- ! building


# A pre-defined value is used to reset the random seed so that results are repeatable.

crv$seed <- 42 

#============================================================
# Rattle timestamp: 2016-01-16 18:03:48 x86_64-w64-mingw32 

# Load the data.

crs$dataset <- read.csv("file:///D:/R-project/turkey/data/data.csv", na.strings=c(".", "NA", "", "?"), strip.white=TRUE, encoding="UTF-8")

#============================================================
# Rattle timestamp: 2016-01-16 18:03:52 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 608 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 425 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 91 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 92 observations

# The following variable selections have been noted.

crs$input <- c("Age.Group", "Sex", "Marital.Status", "Ethnicity",
     "Religion", "Education", "X.Comment..Education", "Number.of.children.in.the.family",
     "Family.Size", "X.Afghanistan...Country.of.Origin", "X.Iran...Country.of.Origin", "X.Iraq...Country.of.Origin",
     "X.Palestine...Country.of.Origin", "X.Pakistan...Country.of.Origin", "X.Sudan...Country.of.Origin", "X.Syria...Country.of.Origin",
     "Which.country.did.you.arrive.from.to.Turkey.", "X.Other....Which.country.did.you.arrive.from.to.Turkey.", "X.1...30days....How.long.did.you.stay.in.that.country..U.00A0.", "X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.1.year.to.less.than.2.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.2.years.to.less.than.3.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.3.years.to.less.than.5.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.5.years.and.more....How.long.did.you.stay.in.that.country..U.00A0.",
     "Why.did.you.decide.to.come.to.Turkey.", "How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", "In.your.country.of.origin..did.you.use.to.work.", "X.Accountant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Architect.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Artist.sculptor.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Author.journalist.writer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Baker.pastry.cook.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Blacksmith.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Bricklayer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Builder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Driver.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Business.services.agent.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Carpenter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Clerk.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Cook.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Craftsman.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electrical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronic.Telecommunications.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronics.mechanic.servicer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farm.hand...laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Gardener.horticultural.grower.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.General.manager.own.or.small.business......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Glassmaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hairdresser.barber.beautician.and.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.in.textile.leather...related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Handicraft.worker.inwood...related.materials.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Helper.cleaner.in.offices..hotels.etc......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Mechanical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Medical.doctor.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Motor.vehicle.mechanic.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Nurse.midwifery.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Police.officer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Religious.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sales.representative.merchant.trader.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Salesperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.cleaning.other.street.service.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Shoe.maker.related.worker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Tailor.dressmaker.hatter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Teacher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Translator.interpreter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Veterinarian.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Waiter.waitresses.bartender.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Welder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Other....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "How.long.have.you.been.in.Turkey..U.00A0.....U.00A0.", "Are.you.registered.with.the.authorities.in.Turkey.", "X.Yes..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.No..Because.I.don.U.0092.t.know.how.to.take.it..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because..I.applied.to.the.authorities..but.I.haven.U.0092.t.received.it.yet..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.did.not.apply.to.Turkish.authorities...Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.Other..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.1", "X.Other.", "Did.you.register.with.UNHCR.", "X.I.want.to.resettle.to.a.third.country.through.UNHCR..Why.did.you.register.with.UNHCR.",
     "X.I.heard.about.UNHCR.from.my.relatives.neighbors.other.compatriots.from.CoO.and.they.told.me.to.approach..Why.did.you.register.with.UNHCR.", "X.UNHCR.would.give.me.documentation..Why.did.you.register.with.UNHCR.", "X.I.want.to.move.to.Greece.and.the.documentation.will.help.me.to.travel...Why.did.you.register.with.UNHCR.", "X.I.don.U.0092.t.know.where.else.to.apply..Why.did.you.register.with.UNHCR.",
     "In.which.city.have.you.been.residing.in.Turkey.", "Have.you.stayed.in.the.camp.in.Turkey..U.00A0.", "Why.did.you.leave.the.camp.and.arrive.in.this.city.", "Do.you.have.any.relatives.left.behind.in.the.camp.or.in.the.city.where.you.used.to.reside.in.Turkey.",
     "In.Turkey..have.you.ever.worked.in.Turkey...PLEASE.TICK.ONLY.ONE.BOX.", "How.did.you.find.job.in.Turkey.", "Did.you.have.work.permit.", "Which.one.among.the.below.describes.your.situation.",
     "Do.you.have.problems.in.relation.to.your.working.conditions.", "X.The.working.hours.are.too.long.when.compared.to.my.salary..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.my.employer.supervisor...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior..by.other.employee.s....Please.explain.in.the.box.below...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.cannot.get.my.salary.in.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary..in.the.amount.we.agreed.on..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.salary.does.not.reflect.the.hardship.of.my.job..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.work.longer.than.we.agreed.on..but.cannot.get.extra.money.for.the.extra.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.My.employer.supervisor.wants.me.to.fulfill.duties.that.are.not.included.in.my.work.definition..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.rude.expressions..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.locals.because.I.am.working..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.Other..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "X.Comment..Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "If.your.children.are.not.registered.in.Turkish.State.schools..do.they.go.to.any.different.type.of.school..U.00A0.Please.explain..U.00A0.", "X.c7.ocuklariniz.Devlet.okullarina.kayitli.degilse..farkli.t.fc.rdeki.okullara.gidiyor.muydu.",
     "If.the.individual.is.over.18..U.0096..Did.you.try.to.continue.your.higher.education.in.Turkey.", "What.was.the.reason.that.you.discontinued.your.education.in.Turkey.", "Why.have.you.not.take.steps.to.continue.your.higher.education.in.Turkey.", "Do.you.have.chronic.health.problems.",
     "Did.you.have.access.to.health.services.in.Turkey.", "X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.People.in.Turkey.are.hostile..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.unite.with.my.relatives.residing.abroad..What.are.your.reasons.to.leave.Turkey.",
     "X.I.do.not.have.any.work.opportunities.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.Exploitation.at.the.workplace..What.are.your.reasons.to.leave.Turkey.", "X.I.have.poor.quality.of.life.in.Turkey...What.are.your.reasons.to.leave.Turkey.", "X.I.feel.isolated.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.I.cannot.benefit.from.medical.services.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X..I.My.children.cannot.continue.education.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.have.security.problems.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.find.Turkish.culture.hard.to.adopt..What.are.your.reasons.to.leave.Turkey.",
     "X.I.do.not.find.myself.comfortable.in.terms.of.my.religious.convictions.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.The.language.is.difficult.for.me..What.are.your.reasons.to.leave.Turkey.", "X..I.want..or.my.children..to.continue.education.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.am.not.going.to.be.resettled.by.UNHCR..What.are.your.reasons.to.leave.Turkey.",
     "X.I.want.to.have.better.future.for.myself.and.my.children...What.are.your.reasons.to.leave.Turkey.", "X.It.is.too.close.to.Syria...What.are.your.reasons.to.leave.Turkey.", "X.Other..What.are.your.reasons.to.leave.Turkey.", "Have.you.tried.to.cross.to.Greece.before.",
     "How.many.times.did.you.attempt.to.cross.Greece.", "Do.you.plan.to.try.again.", "Have.you.ever.been.stopped.and.returned.to.Turkey.by.the.Greek.Coast.Guards", "What.are.your.future.plans..intentions.",
     "Which.country.is.your.final.destination.", "X.I.have.relatives.in.this.country..Why.do.you.want.to.go.to.this.country.", "X.I.know.that.they.will.financially.help.me.there......Why.do.you.want.to.go.to.this.country.", "X.I.can.work.there..Why.do.you.want.to.go.to.this.country.",
     "X.I.want.to.continue.my.education.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.be.a.citizen.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.apply.for.asylum.there..Why.do.you.want.to.go.to.this.country.", "X.My.children.would.have.better.future..Why.do.you.want.to.go.to.this.country.",
     "Would.you.prefer.to.stay.in.Turkey.rather.than.going.to.another.country..if.you.had.the.chance.", "X.Employment..What.would.make.you.stay.in.Turkey.", "X.Education.opportunities..What.would.make.you.stay.in.Turkey.", "X.Material.support..What.would.make.you.stay.in.Turkey.",
     "X.Shelter.support..What.would.make.you.stay.in.Turkey.", "X.Unaccompanied.and.separated.child....Any.specific.needs.identified.", "X.Female.Head.of.Household..Any.specific.needs.identified.", "X.Medical.problems..Any.specific.needs.identified.",
     "X.Disabled...Any.specific.needs.identified.", "X.Victim.of.torture...Any.specific.needs.identified.", "X.Pregnant.woman...Any.specific.needs.identified.", "X.Elderly...Any.specific.needs.identified.",
     "Date.of.the.interview", "Name.of.the.Interviewer", "Location.of.the.Interview")

crs$numeric <- c("X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.People.in.Turkey.are.hostile..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.unite.with.my.relatives.residing.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.have.any.work.opportunities.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.Exploitation.at.the.workplace..What.are.your.reasons.to.leave.Turkey.", "X.I.have.poor.quality.of.life.in.Turkey...What.are.your.reasons.to.leave.Turkey.", "X.I.feel.isolated.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.cannot.benefit.from.medical.services.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X..I.My.children.cannot.continue.education.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.have.security.problems.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.find.Turkish.culture.hard.to.adopt..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.find.myself.comfortable.in.terms.of.my.religious.convictions.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.The.language.is.difficult.for.me..What.are.your.reasons.to.leave.Turkey.", "X..I.want..or.my.children..to.continue.education.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.am.not.going.to.be.resettled.by.UNHCR..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.have.better.future.for.myself.and.my.children...What.are.your.reasons.to.leave.Turkey.",
     "X.It.is.too.close.to.Syria...What.are.your.reasons.to.leave.Turkey.", "X.Other..What.are.your.reasons.to.leave.Turkey.", "X.Employment..What.would.make.you.stay.in.Turkey.", "X.Education.opportunities..What.would.make.you.stay.in.Turkey.",
     "X.Material.support..What.would.make.you.stay.in.Turkey.", "X.Shelter.support..What.would.make.you.stay.in.Turkey.")

crs$categoric <- c("Age.Group", "Sex", "Marital.Status", "Ethnicity",
     "Religion", "Education", "X.Comment..Education", "Number.of.children.in.the.family",
     "Family.Size", "X.Afghanistan...Country.of.Origin", "X.Iran...Country.of.Origin", "X.Iraq...Country.of.Origin",
     "X.Palestine...Country.of.Origin", "X.Pakistan...Country.of.Origin", "X.Sudan...Country.of.Origin", "X.Syria...Country.of.Origin",
     "Which.country.did.you.arrive.from.to.Turkey.", "X.Other....Which.country.did.you.arrive.from.to.Turkey.", "X.1...30days....How.long.did.you.stay.in.that.country..U.00A0.", "X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.1.year.to.less.than.2.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.2.years.to.less.than.3.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.3.years.to.less.than.5.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.5.years.and.more....How.long.did.you.stay.in.that.country..U.00A0.",
     "Why.did.you.decide.to.come.to.Turkey.", "How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", "In.your.country.of.origin..did.you.use.to.work.", "X.Accountant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Architect.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Artist.sculptor.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Author.journalist.writer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Baker.pastry.cook.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Blacksmith.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Bricklayer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Builder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Driver.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Business.services.agent.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Carpenter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Clerk.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Cook.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Craftsman.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electrical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronic.Telecommunications.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronics.mechanic.servicer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farm.hand...laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Gardener.horticultural.grower.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.General.manager.own.or.small.business......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Glassmaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hairdresser.barber.beautician.and.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.in.textile.leather...related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Handicraft.worker.inwood...related.materials.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Helper.cleaner.in.offices..hotels.etc......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Mechanical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Medical.doctor.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Motor.vehicle.mechanic.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Nurse.midwifery.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Police.officer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Religious.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sales.representative.merchant.trader.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Salesperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.cleaning.other.street.service.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Shoe.maker.related.worker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Tailor.dressmaker.hatter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Teacher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Translator.interpreter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Veterinarian.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Waiter.waitresses.bartender.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Welder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Other....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "How.long.have.you.been.in.Turkey..U.00A0.....U.00A0.", "Are.you.registered.with.the.authorities.in.Turkey.", "X.Yes..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.No..Because.I.don.U.0092.t.know.how.to.take.it..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because..I.applied.to.the.authorities..but.I.haven.U.0092.t.received.it.yet..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.did.not.apply.to.Turkish.authorities...Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.Other..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.1", "X.Other.", "Did.you.register.with.UNHCR.", "X.I.want.to.resettle.to.a.third.country.through.UNHCR..Why.did.you.register.with.UNHCR.",
     "X.I.heard.about.UNHCR.from.my.relatives.neighbors.other.compatriots.from.CoO.and.they.told.me.to.approach..Why.did.you.register.with.UNHCR.", "X.UNHCR.would.give.me.documentation..Why.did.you.register.with.UNHCR.", "X.I.want.to.move.to.Greece.and.the.documentation.will.help.me.to.travel...Why.did.you.register.with.UNHCR.", "X.I.don.U.0092.t.know.where.else.to.apply..Why.did.you.register.with.UNHCR.",
     "In.which.city.have.you.been.residing.in.Turkey.", "Have.you.stayed.in.the.camp.in.Turkey..U.00A0.", "Why.did.you.leave.the.camp.and.arrive.in.this.city.", "Do.you.have.any.relatives.left.behind.in.the.camp.or.in.the.city.where.you.used.to.reside.in.Turkey.",
     "In.Turkey..have.you.ever.worked.in.Turkey...PLEASE.TICK.ONLY.ONE.BOX.", "How.did.you.find.job.in.Turkey.", "Did.you.have.work.permit.", "Which.one.among.the.below.describes.your.situation.",
     "Do.you.have.problems.in.relation.to.your.working.conditions.", "X.The.working.hours.are.too.long.when.compared.to.my.salary..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.my.employer.supervisor...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior..by.other.employee.s....Please.explain.in.the.box.below...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.cannot.get.my.salary.in.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary..in.the.amount.we.agreed.on..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.salary.does.not.reflect.the.hardship.of.my.job..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.work.longer.than.we.agreed.on..but.cannot.get.extra.money.for.the.extra.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.My.employer.supervisor.wants.me.to.fulfill.duties.that.are.not.included.in.my.work.definition..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.rude.expressions..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.locals.because.I.am.working..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.Other..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "X.Comment..Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "If.your.children.are.not.registered.in.Turkish.State.schools..do.they.go.to.any.different.type.of.school..U.00A0.Please.explain..U.00A0.", "X.c7.ocuklariniz.Devlet.okullarina.kayitli.degilse..farkli.t.fc.rdeki.okullara.gidiyor.muydu.",
     "If.the.individual.is.over.18..U.0096..Did.you.try.to.continue.your.higher.education.in.Turkey.", "What.was.the.reason.that.you.discontinued.your.education.in.Turkey.", "Why.have.you.not.take.steps.to.continue.your.higher.education.in.Turkey.", "Do.you.have.chronic.health.problems.",
     "Did.you.have.access.to.health.services.in.Turkey.", "Have.you.tried.to.cross.to.Greece.before.", "How.many.times.did.you.attempt.to.cross.Greece.", "Do.you.plan.to.try.again.",
     "Have.you.ever.been.stopped.and.returned.to.Turkey.by.the.Greek.Coast.Guards", "What.are.your.future.plans..intentions.", "Which.country.is.your.final.destination.", "X.I.have.relatives.in.this.country..Why.do.you.want.to.go.to.this.country.",
     "X.I.know.that.they.will.financially.help.me.there......Why.do.you.want.to.go.to.this.country.", "X.I.can.work.there..Why.do.you.want.to.go.to.this.country.", "X.I.want.to.continue.my.education.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.be.a.citizen.there..Why.do.you.want.to.go.to.this.country.",
     "X.I.can.apply.for.asylum.there..Why.do.you.want.to.go.to.this.country.", "X.My.children.would.have.better.future..Why.do.you.want.to.go.to.this.country.", "Would.you.prefer.to.stay.in.Turkey.rather.than.going.to.another.country..if.you.had.the.chance.", "X.Unaccompanied.and.separated.child....Any.specific.needs.identified.",
     "X.Female.Head.of.Household..Any.specific.needs.identified.", "X.Medical.problems..Any.specific.needs.identified.", "X.Disabled...Any.specific.needs.identified.", "X.Victim.of.torture...Any.specific.needs.identified.",
     "X.Pregnant.woman...Any.specific.needs.identified.", "X.Elderly...Any.specific.needs.identified.", "Date.of.the.interview", "Name.of.the.Interviewer",
     "Location.of.the.Interview")

crs$target  <- "startlanguage"
crs$risk    <- NULL
crs$ident   <- c("X", "id", "submitdate")
crs$ignore  <- c("token", "X.Azerbaijan...Country.of.Origin", "X.Cameroon...Country.of.Origin", "X.China...Country.of.Origin", "X.Congo...Country.of.Origin", "X.Cote.D.U.0092.Ivoire...Country.of.Origin", "X.Dem..Rep..of.Congo...Country.of.Origin", "X.Eritrea...Country.of.Origin", "X.Ethiopia...Country.of.Origin", "X.Uzbekistan...Country.of.Origin", "X.Kyrgyzstan...Country.of.Origin", "X.Liberia...Country.of.Origin", "X.Mauritania...Country.of.Origin", "X.Myanmar...Country.of.Origin", "X.Sierra.Leone...Country.of.Origin", "X.Somali...Country.of.Origin", "X.Sri.Lanka...Country.of.Origin", "X.Other..Country.of.Origin", "X.Aircraft.pilot.related.professionals.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Building.caretaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Butcher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Computer.equipment.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Computer.programmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Dairy.producer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Dentist.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Domestic.helper.cleaner.Housekeeper.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Doorkeeper.watchperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Garbage.collector.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hunter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Jewel.maker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Judge.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Market.orientedanimal.producer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.assistant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Photographer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Production.operationsdepartment.manager.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Radio.TV.related.announcer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Safety.quality.inspectors.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Secretary.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Senior.official.of.political.party.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sewing.machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Ships.U.0092..deck.crew.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Statistician.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sweeper.related.laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.University.teaching.staff.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Vehicle.window.related.cleaners.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Weaver.knitter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.My.employer.holds.my.legal.documents.and.does.not.give.them.back..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Please.Explain", "X.LGBTi..Any.specific.needs.identified.")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2016-01-16 18:04:45 x86_64-w64-mingw32 

# Note the user selections. 

# Build the training/validate/test datasets.

set.seed(crv$seed) 
crs$nobs <- nrow(crs$dataset) # 608 observations 
crs$sample <- crs$train <- sample(nrow(crs$dataset), 0.7*crs$nobs) # 425 observations
crs$validate <- sample(setdiff(seq_len(nrow(crs$dataset)), crs$train), 0.15*crs$nobs) # 91 observations
crs$test <- setdiff(setdiff(seq_len(nrow(crs$dataset)), crs$train), crs$validate) # 92 observations

# The following variable selections have been noted.

crs$input <- c("startlanguage", "Age.Group", "Sex", "Marital.Status",
     "Ethnicity", "Religion", "Education", "X.Comment..Education",
     "Number.of.children.in.the.family", "Family.Size", "X.Afghanistan...Country.of.Origin", "X.Iran...Country.of.Origin",
     "X.Iraq...Country.of.Origin", "X.Palestine...Country.of.Origin", "X.Pakistan...Country.of.Origin", "X.Sudan...Country.of.Origin",
     "X.Syria...Country.of.Origin", "Which.country.did.you.arrive.from.to.Turkey.", "X.Other....Which.country.did.you.arrive.from.to.Turkey.", "X.1...30days....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.", "X.1.year.to.less.than.2.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.2.years.to.less.than.3.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.3.years.to.less.than.5.years....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.5.years.and.more....How.long.did.you.stay.in.that.country..U.00A0.", "Why.did.you.decide.to.come.to.Turkey.", "How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", "In.your.country.of.origin..did.you.use.to.work.",
     "X.Accountant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Architect.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Artist.sculptor.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Author.journalist.writer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Baker.pastry.cook.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Blacksmith.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Bricklayer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Builder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Driver.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Business.services.agent.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Carpenter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Clerk.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Cook.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Craftsman.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electrical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronic.Telecommunications.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Electronics.mechanic.servicer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farm.hand...laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Gardener.horticultural.grower.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.General.manager.own.or.small.business......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Glassmaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hairdresser.barber.beautician.and.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Handicraft.worker.in.textile.leather...related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.inwood...related.materials.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Helper.cleaner.in.offices..hotels.etc......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Mechanical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.doctor.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Motor.vehicle.mechanic.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Nurse.midwifery.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Police.officer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Religious.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sales.representative.merchant.trader.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Salesperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Shoe.cleaning.other.street.service.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.maker.related.worker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Tailor.dressmaker.hatter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Teacher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Translator.interpreter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Veterinarian.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Waiter.waitresses.bartender.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Welder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Other....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "How.long.have.you.been.in.Turkey..U.00A0.....U.00A0.", "Are.you.registered.with.the.authorities.in.Turkey.", "X.Yes..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.No..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.don.U.0092.t.know.how.to.take.it..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because..I.applied.to.the.authorities..but.I.haven.U.0092.t.received.it.yet..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.did.not.apply.to.Turkish.authorities...Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.Other..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.1", "X.Other.", "Did.you.register.with.UNHCR.",
     "X.I.want.to.resettle.to.a.third.country.through.UNHCR..Why.did.you.register.with.UNHCR.", "X.I.heard.about.UNHCR.from.my.relatives.neighbors.other.compatriots.from.CoO.and.they.told.me.to.approach..Why.did.you.register.with.UNHCR.", "X.UNHCR.would.give.me.documentation..Why.did.you.register.with.UNHCR.", "X.I.want.to.move.to.Greece.and.the.documentation.will.help.me.to.travel...Why.did.you.register.with.UNHCR.",
     "X.I.don.U.0092.t.know.where.else.to.apply..Why.did.you.register.with.UNHCR.", "In.which.city.have.you.been.residing.in.Turkey.", "Have.you.stayed.in.the.camp.in.Turkey..U.00A0.", "Why.did.you.leave.the.camp.and.arrive.in.this.city.",
     "Do.you.have.any.relatives.left.behind.in.the.camp.or.in.the.city.where.you.used.to.reside.in.Turkey.", "In.Turkey..have.you.ever.worked.in.Turkey...PLEASE.TICK.ONLY.ONE.BOX.", "How.did.you.find.job.in.Turkey.", "Did.you.have.work.permit.",
     "Which.one.among.the.below.describes.your.situation.", "Do.you.have.problems.in.relation.to.your.working.conditions.", "X.The.working.hours.are.too.long.when.compared.to.my.salary..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.my.employer.supervisor...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.face.annoying.behavior..by.other.employee.s....Please.explain.in.the.box.below...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary.in.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary..in.the.amount.we.agreed.on..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.salary.does.not.reflect.the.hardship.of.my.job..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.work.longer.than.we.agreed.on..but.cannot.get.extra.money.for.the.extra.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.employer.supervisor.wants.me.to.fulfill.duties.that.are.not.included.in.my.work.definition..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.rude.expressions..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.locals.because.I.am.working..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.Other..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "X.Comment..Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "If.your.children.are.not.registered.in.Turkish.State.schools..do.they.go.to.any.different.type.of.school..U.00A0.Please.explain..U.00A0.",
     "X.c7.ocuklariniz.Devlet.okullarina.kayitli.degilse..farkli.t.fc.rdeki.okullara.gidiyor.muydu.", "If.the.individual.is.over.18..U.0096..Did.you.try.to.continue.your.higher.education.in.Turkey.", "What.was.the.reason.that.you.discontinued.your.education.in.Turkey.", "Why.have.you.not.take.steps.to.continue.your.higher.education.in.Turkey.",
     "Do.you.have.chronic.health.problems.", "Did.you.have.access.to.health.services.in.Turkey.", "X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.People.in.Turkey.are.hostile..What.are.your.reasons.to.leave.Turkey.",
     "X.I.want.to.unite.with.my.relatives.residing.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.have.any.work.opportunities.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.Exploitation.at.the.workplace..What.are.your.reasons.to.leave.Turkey.", "X.I.have.poor.quality.of.life.in.Turkey...What.are.your.reasons.to.leave.Turkey.",
     "X.I.feel.isolated.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.cannot.benefit.from.medical.services.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X..I.My.children.cannot.continue.education.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.have.security.problems.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.I.find.Turkish.culture.hard.to.adopt..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.find.myself.comfortable.in.terms.of.my.religious.convictions.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.The.language.is.difficult.for.me..What.are.your.reasons.to.leave.Turkey.", "X..I.want..or.my.children..to.continue.education.abroad..What.are.your.reasons.to.leave.Turkey.",
     "X.I.am.not.going.to.be.resettled.by.UNHCR..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.have.better.future.for.myself.and.my.children...What.are.your.reasons.to.leave.Turkey.", "X.It.is.too.close.to.Syria...What.are.your.reasons.to.leave.Turkey.", "X.Other..What.are.your.reasons.to.leave.Turkey.",
     "Have.you.tried.to.cross.to.Greece.before.", "How.many.times.did.you.attempt.to.cross.Greece.", "Do.you.plan.to.try.again.", "Have.you.ever.been.stopped.and.returned.to.Turkey.by.the.Greek.Coast.Guards",
     "What.are.your.future.plans..intentions.", "Which.country.is.your.final.destination.", "X.I.have.relatives.in.this.country..Why.do.you.want.to.go.to.this.country.", "X.I.know.that.they.will.financially.help.me.there......Why.do.you.want.to.go.to.this.country.",
     "X.I.can.work.there..Why.do.you.want.to.go.to.this.country.", "X.I.want.to.continue.my.education.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.be.a.citizen.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.apply.for.asylum.there..Why.do.you.want.to.go.to.this.country.",
     "X.My.children.would.have.better.future..Why.do.you.want.to.go.to.this.country.", "Would.you.prefer.to.stay.in.Turkey.rather.than.going.to.another.country..if.you.had.the.chance.", "X.Employment..What.would.make.you.stay.in.Turkey.", "X.Education.opportunities..What.would.make.you.stay.in.Turkey.",
     "X.Material.support..What.would.make.you.stay.in.Turkey.", "X.Shelter.support..What.would.make.you.stay.in.Turkey.", "X.Unaccompanied.and.separated.child....Any.specific.needs.identified.", "X.Female.Head.of.Household..Any.specific.needs.identified.",
     "X.Medical.problems..Any.specific.needs.identified.", "X.Disabled...Any.specific.needs.identified.", "X.Victim.of.torture...Any.specific.needs.identified.", "X.Pregnant.woman...Any.specific.needs.identified.",
     "X.Elderly...Any.specific.needs.identified.", "Date.of.the.interview", "Name.of.the.Interviewer", "Location.of.the.Interview")

crs$numeric <- c("X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.People.in.Turkey.are.hostile..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.unite.with.my.relatives.residing.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.have.any.work.opportunities.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.Exploitation.at.the.workplace..What.are.your.reasons.to.leave.Turkey.", "X.I.have.poor.quality.of.life.in.Turkey...What.are.your.reasons.to.leave.Turkey.", "X.I.feel.isolated.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.cannot.benefit.from.medical.services.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X..I.My.children.cannot.continue.education.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.have.security.problems.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.find.Turkish.culture.hard.to.adopt..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.find.myself.comfortable.in.terms.of.my.religious.convictions.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.The.language.is.difficult.for.me..What.are.your.reasons.to.leave.Turkey.", "X..I.want..or.my.children..to.continue.education.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.am.not.going.to.be.resettled.by.UNHCR..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.have.better.future.for.myself.and.my.children...What.are.your.reasons.to.leave.Turkey.",
     "X.It.is.too.close.to.Syria...What.are.your.reasons.to.leave.Turkey.", "X.Other..What.are.your.reasons.to.leave.Turkey.", "X.Employment..What.would.make.you.stay.in.Turkey.", "X.Education.opportunities..What.would.make.you.stay.in.Turkey.",
     "X.Material.support..What.would.make.you.stay.in.Turkey.", "X.Shelter.support..What.would.make.you.stay.in.Turkey.")

crs$categoric <- c("startlanguage", "Age.Group", "Sex", "Marital.Status",
     "Ethnicity", "Religion", "Education", "X.Comment..Education",
     "Number.of.children.in.the.family", "Family.Size", "X.Afghanistan...Country.of.Origin", "X.Iran...Country.of.Origin",
     "X.Iraq...Country.of.Origin", "X.Palestine...Country.of.Origin", "X.Pakistan...Country.of.Origin", "X.Sudan...Country.of.Origin",
     "X.Syria...Country.of.Origin", "Which.country.did.you.arrive.from.to.Turkey.", "X.Other....Which.country.did.you.arrive.from.to.Turkey.", "X.1...30days....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.", "X.1.year.to.less.than.2.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.2.years.to.less.than.3.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.3.years.to.less.than.5.years....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.5.years.and.more....How.long.did.you.stay.in.that.country..U.00A0.", "Why.did.you.decide.to.come.to.Turkey.", "How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", "In.your.country.of.origin..did.you.use.to.work.",
     "X.Accountant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Architect.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Artist.sculptor.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Author.journalist.writer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Baker.pastry.cook.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Blacksmith.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Bricklayer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Builder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Driver.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Business.services.agent.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Carpenter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Clerk.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Cook.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Craftsman.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electrical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronic.Telecommunications.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Electronics.mechanic.servicer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farm.hand...laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Gardener.horticultural.grower.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.General.manager.own.or.small.business......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Glassmaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hairdresser.barber.beautician.and.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Handicraft.worker.in.textile.leather...related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.inwood...related.materials.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Helper.cleaner.in.offices..hotels.etc......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Mechanical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.doctor.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Motor.vehicle.mechanic.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Nurse.midwifery.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Police.officer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Religious.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sales.representative.merchant.trader.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Salesperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Shoe.cleaning.other.street.service.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.maker.related.worker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Tailor.dressmaker.hatter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Teacher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Translator.interpreter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Veterinarian.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Waiter.waitresses.bartender.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Welder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Other....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "How.long.have.you.been.in.Turkey..U.00A0.....U.00A0.", "Are.you.registered.with.the.authorities.in.Turkey.", "X.Yes..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.No..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.don.U.0092.t.know.how.to.take.it..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because..I.applied.to.the.authorities..but.I.haven.U.0092.t.received.it.yet..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.did.not.apply.to.Turkish.authorities...Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.Other..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.1", "X.Other.", "Did.you.register.with.UNHCR.",
     "X.I.want.to.resettle.to.a.third.country.through.UNHCR..Why.did.you.register.with.UNHCR.", "X.I.heard.about.UNHCR.from.my.relatives.neighbors.other.compatriots.from.CoO.and.they.told.me.to.approach..Why.did.you.register.with.UNHCR.", "X.UNHCR.would.give.me.documentation..Why.did.you.register.with.UNHCR.", "X.I.want.to.move.to.Greece.and.the.documentation.will.help.me.to.travel...Why.did.you.register.with.UNHCR.",
     "X.I.don.U.0092.t.know.where.else.to.apply..Why.did.you.register.with.UNHCR.", "In.which.city.have.you.been.residing.in.Turkey.", "Have.you.stayed.in.the.camp.in.Turkey..U.00A0.", "Why.did.you.leave.the.camp.and.arrive.in.this.city.",
     "Do.you.have.any.relatives.left.behind.in.the.camp.or.in.the.city.where.you.used.to.reside.in.Turkey.", "In.Turkey..have.you.ever.worked.in.Turkey...PLEASE.TICK.ONLY.ONE.BOX.", "How.did.you.find.job.in.Turkey.", "Did.you.have.work.permit.",
     "Which.one.among.the.below.describes.your.situation.", "Do.you.have.problems.in.relation.to.your.working.conditions.", "X.The.working.hours.are.too.long.when.compared.to.my.salary..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.my.employer.supervisor...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.face.annoying.behavior..by.other.employee.s....Please.explain.in.the.box.below...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary.in.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary..in.the.amount.we.agreed.on..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.salary.does.not.reflect.the.hardship.of.my.job..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.work.longer.than.we.agreed.on..but.cannot.get.extra.money.for.the.extra.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.employer.supervisor.wants.me.to.fulfill.duties.that.are.not.included.in.my.work.definition..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.rude.expressions..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.locals.because.I.am.working..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.Other..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "X.Comment..Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "If.your.children.are.not.registered.in.Turkish.State.schools..do.they.go.to.any.different.type.of.school..U.00A0.Please.explain..U.00A0.",
     "X.c7.ocuklariniz.Devlet.okullarina.kayitli.degilse..farkli.t.fc.rdeki.okullara.gidiyor.muydu.", "If.the.individual.is.over.18..U.0096..Did.you.try.to.continue.your.higher.education.in.Turkey.", "What.was.the.reason.that.you.discontinued.your.education.in.Turkey.", "Why.have.you.not.take.steps.to.continue.your.higher.education.in.Turkey.",
     "Do.you.have.chronic.health.problems.", "Did.you.have.access.to.health.services.in.Turkey.", "Have.you.tried.to.cross.to.Greece.before.", "How.many.times.did.you.attempt.to.cross.Greece.",
     "Do.you.plan.to.try.again.", "Have.you.ever.been.stopped.and.returned.to.Turkey.by.the.Greek.Coast.Guards", "What.are.your.future.plans..intentions.", "Which.country.is.your.final.destination.",
     "X.I.have.relatives.in.this.country..Why.do.you.want.to.go.to.this.country.", "X.I.know.that.they.will.financially.help.me.there......Why.do.you.want.to.go.to.this.country.", "X.I.can.work.there..Why.do.you.want.to.go.to.this.country.", "X.I.want.to.continue.my.education.there..Why.do.you.want.to.go.to.this.country.",
     "X.I.can.be.a.citizen.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.apply.for.asylum.there..Why.do.you.want.to.go.to.this.country.", "X.My.children.would.have.better.future..Why.do.you.want.to.go.to.this.country.", "Would.you.prefer.to.stay.in.Turkey.rather.than.going.to.another.country..if.you.had.the.chance.",
     "X.Unaccompanied.and.separated.child....Any.specific.needs.identified.", "X.Female.Head.of.Household..Any.specific.needs.identified.", "X.Medical.problems..Any.specific.needs.identified.", "X.Disabled...Any.specific.needs.identified.",
     "X.Victim.of.torture...Any.specific.needs.identified.", "X.Pregnant.woman...Any.specific.needs.identified.", "X.Elderly...Any.specific.needs.identified.", "Date.of.the.interview",
     "Name.of.the.Interviewer", "Location.of.the.Interview")

crs$target  <- NULL
crs$risk    <- NULL
crs$ident   <- "submitdate"
crs$ignore  <- c("X", "id", "token", "X.Azerbaijan...Country.of.Origin", "X.Cameroon...Country.of.Origin", "X.China...Country.of.Origin", "X.Congo...Country.of.Origin", "X.Cote.D.U.0092.Ivoire...Country.of.Origin", "X.Dem..Rep..of.Congo...Country.of.Origin", "X.Eritrea...Country.of.Origin", "X.Ethiopia...Country.of.Origin", "X.Uzbekistan...Country.of.Origin", "X.Kyrgyzstan...Country.of.Origin", "X.Liberia...Country.of.Origin", "X.Mauritania...Country.of.Origin", "X.Myanmar...Country.of.Origin", "X.Sierra.Leone...Country.of.Origin", "X.Somali...Country.of.Origin", "X.Sri.Lanka...Country.of.Origin", "X.Other..Country.of.Origin", "X.Aircraft.pilot.related.professionals.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Building.caretaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Butcher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Computer.equipment.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Computer.programmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Dairy.producer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Dentist.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Domestic.helper.cleaner.Housekeeper.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Doorkeeper.watchperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Garbage.collector.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hunter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Jewel.maker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Judge.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Market.orientedanimal.producer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.assistant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Photographer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Production.operationsdepartment.manager.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Radio.TV.related.announcer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Safety.quality.inspectors.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Secretary.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Senior.official.of.political.party.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sewing.machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Ships.U.0092..deck.crew.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Statistician.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sweeper.related.laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.University.teaching.staff.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Vehicle.window.related.cleaners.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Weaver.knitter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.My.employer.holds.my.legal.documents.and.does.not.give.them.back..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Please.Explain", "X.LGBTi..Any.specific.needs.identified.")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2016-01-16 18:06:47 x86_64-w64-mingw32 

# Display box plots for the selected variables. 

# Use ggplot2 to generate box plot for X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.

library(ggplot2) # Provides ggplot(), aes(), geom_boxplot(), stat_summary(), xlab(), ggtitle(), theme().

# Generate a box plot.

p01 <- crs %>%
  with(dataset[sample,]) %>%
  ggplot(aes(y=X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.)) +
  geom_boxplot(aes(x="All"), notch=TRUE, fill="grey") +
  stat_summary(aes(x="All"), fun.y=mean, geom="point", shape=8) +
  xlab("Rattle 2016-Jan-16 18:06:47 legoupil") +
  ggtitle("Distribution of X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey. (sample)") +
  theme(legend.position="none")

# Display the plots.

library(gridExtra) # Provides grid.arrange().

grid.arrange(p01)

#============================================================
# Rattle timestamp: 2016-01-16 18:06:49 x86_64-w64-mingw32 

# The 'gplots' package provides the 'barplot2' function.

library(gplots, quietly=TRUE)

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$Age.Group)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="Age.Group", ylim=c(0, 461), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+15, ds[,ord])

# Add a title to the plot.

title(main="Distribution of Age.Group (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$Sex)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="Sex", ylim=c(0, 373), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+12, ds[,ord])

# Add a title to the plot.

title(main="Distribution of Sex (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$Marital.Status)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="Marital.Status", ylim=c(0, 294), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+10, ds[,ord])

# Add a title to the plot.

title(main="Distribution of Marital.Status (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$Ethnicity)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="Ethnicity", ylim=c(0, 36), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+1, ds[,ord])

# Add a title to the plot.

title(main="Distribution of Ethnicity (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", ylim=c(0, 53), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+2, ds[,ord])

# Add a title to the plot.

title(main="Distribution of How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$In.your.country.of.origin..did.you.use.to.work.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="In.your.country.of.origin..did.you.use.to.work.", ylim=c(0, 290), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+10, ds[,ord])

# Add a title to the plot.

title(main="Distribution of In.your.country.of.origin..did.you.use.to.work. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:50 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Unaccompanied.and.separated.child....Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Unaccompanied.and.separated.child....Any.specific.needs.identified.", ylim=c(0, 500), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+17, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Unaccompanied.and.separated.child....Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:51 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Female.Head.of.Household..Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Female.Head.of.Household..Any.specific.needs.identified.", ylim=c(0, 485), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+16, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Female.Head.of.Household..Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Medical.problems..Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Medical.problems..Any.specific.needs.identified.", ylim=c(0, 482), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+16, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Medical.problems..Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Disabled...Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Disabled...Any.specific.needs.identified.", ylim=c(0, 503), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+17, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Disabled...Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Victim.of.torture...Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Victim.of.torture...Any.specific.needs.identified.", ylim=c(0, 494), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+16, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Victim.of.torture...Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Pregnant.woman...Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Pregnant.woman...Any.specific.needs.identified.", ylim=c(0, 503), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+17, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Pregnant.woman...Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$X.Elderly...Any.specific.needs.identified.)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="X.Elderly...Any.specific.needs.identified.", ylim=c(0, 503), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+17, ds[,ord])

# Add a title to the plot.

title(main="Distribution of X.Elderly...Any.specific.needs.identified. (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$Name.of.the.Interviewer)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="Name.of.the.Interviewer", ylim=c(0, 112), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+4, ds[,ord])

# Add a title to the plot.

title(main="Distribution of Name.of.the.Interviewer (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:06:52 x86_64-w64-mingw32 

# Bar Plot 

# Generate the summary data for plotting.

ds <- rbind(summary(na.omit(crs$dataset[crs$sample,]$Location.of.the.Interview)))

# Sort the entries.

ord <- order(ds[1,], decreasing=TRUE)

# Plot the data.

bp <-  barplot2(ds[,ord], beside=TRUE, ylab="Frequency", xlab="Location.of.the.Interview", ylim=c(0, 115), col=colorspace::rainbow_hcl(1))

# Add the actual frequencies.

text(bp, ds[,ord]+4, ds[,ord])

# Add a title to the plot.

title(main="Distribution of Location.of.the.Interview (sample)",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))

#============================================================
# Rattle timestamp: 2016-01-16 18:09:25 x86_64-w64-mingw32 

# Remap variables. 

# Turn two factors into one factor.

  crs$dataset[, "TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0."] <- interaction(paste(crs$dataset[["X.1...30days....How.long.did.you.stay.in.that.country..U.00A0."]], "_",crs$dataset[["X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0."]], sep=""))
  crs$dataset[["TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0."]][grepl("^NA_|_NA$", crs$dataset[["TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0."]])] <- NA
  crs$dataset[["TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0."]] <- as.factor(as.character(crs$dataset[["TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0."]]))

#============================================================
# Rattle timestamp: 2016-01-16 18:09:31 x86_64-w64-mingw32 

# Note the user selections. 

# The following variable selections have been noted.

crs$input <- c("startlanguage", "Age.Group", "Sex", "Marital.Status",
     "Ethnicity", "Religion", "Education", "X.Comment..Education",
     "Number.of.children.in.the.family", "Family.Size", "X.Afghanistan...Country.of.Origin", "X.Iran...Country.of.Origin",
     "X.Iraq...Country.of.Origin", "X.Palestine...Country.of.Origin", "X.Pakistan...Country.of.Origin", "X.Sudan...Country.of.Origin",
     "X.Syria...Country.of.Origin", "Which.country.did.you.arrive.from.to.Turkey.", "X.Other....Which.country.did.you.arrive.from.to.Turkey.", "X.1.year.to.less.than.2.years....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.2.years.to.less.than.3.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.3.years.to.less.than.5.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.5.years.and.more....How.long.did.you.stay.in.that.country..U.00A0.", "Why.did.you.decide.to.come.to.Turkey.",
     "How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", "In.your.country.of.origin..did.you.use.to.work.", "X.Accountant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Architect.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Artist.sculptor.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Author.journalist.writer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Baker.pastry.cook.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Blacksmith.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Bricklayer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Builder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Driver.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Business.services.agent.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Carpenter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Clerk.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Cook.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Craftsman.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Electrical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronic.Telecommunications.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronics.mechanic.servicer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Farmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farm.hand...laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Gardener.horticultural.grower.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.General.manager.own.or.small.business......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Glassmaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hairdresser.barber.beautician.and.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.in.textile.leather...related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.inwood...related.materials.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Helper.cleaner.in.offices..hotels.etc......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Mechanical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.doctor.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Motor.vehicle.mechanic.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Nurse.midwifery.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Police.officer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Religious.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Sales.representative.merchant.trader.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Salesperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.cleaning.other.street.service.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.maker.related.worker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Tailor.dressmaker.hatter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Teacher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Translator.interpreter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Veterinarian.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Waiter.waitresses.bartender.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Welder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Other....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "How.long.have.you.been.in.Turkey..U.00A0.....U.00A0.",
     "Are.you.registered.with.the.authorities.in.Turkey.", "X.Yes..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.don.U.0092.t.know.how.to.take.it..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.No..Because..I.applied.to.the.authorities..but.I.haven.U.0092.t.received.it.yet..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.did.not.apply.to.Turkish.authorities...Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.Other..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.1",
     "X.Other.", "Did.you.register.with.UNHCR.", "X.I.want.to.resettle.to.a.third.country.through.UNHCR..Why.did.you.register.with.UNHCR.", "X.I.heard.about.UNHCR.from.my.relatives.neighbors.other.compatriots.from.CoO.and.they.told.me.to.approach..Why.did.you.register.with.UNHCR.",
     "X.UNHCR.would.give.me.documentation..Why.did.you.register.with.UNHCR.", "X.I.want.to.move.to.Greece.and.the.documentation.will.help.me.to.travel...Why.did.you.register.with.UNHCR.", "X.I.don.U.0092.t.know.where.else.to.apply..Why.did.you.register.with.UNHCR.", "In.which.city.have.you.been.residing.in.Turkey.",
     "Have.you.stayed.in.the.camp.in.Turkey..U.00A0.", "Why.did.you.leave.the.camp.and.arrive.in.this.city.", "Do.you.have.any.relatives.left.behind.in.the.camp.or.in.the.city.where.you.used.to.reside.in.Turkey.", "In.Turkey..have.you.ever.worked.in.Turkey...PLEASE.TICK.ONLY.ONE.BOX.",
     "How.did.you.find.job.in.Turkey.", "Did.you.have.work.permit.", "Which.one.among.the.below.describes.your.situation.", "Do.you.have.problems.in.relation.to.your.working.conditions.",
     "X.The.working.hours.are.too.long.when.compared.to.my.salary..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.my.employer.supervisor...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior..by.other.employee.s....Please.explain.in.the.box.below...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary.in.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.cannot.get.my.salary..in.the.amount.we.agreed.on..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.salary.does.not.reflect.the.hardship.of.my.job..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.work.longer.than.we.agreed.on..but.cannot.get.extra.money.for.the.extra.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.employer.supervisor.wants.me.to.fulfill.duties.that.are.not.included.in.my.work.definition..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.face.rude.expressions..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.locals.because.I.am.working..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.Other..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.",
     "X.Comment..Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "If.your.children.are.not.registered.in.Turkish.State.schools..do.they.go.to.any.different.type.of.school..U.00A0.Please.explain..U.00A0.", "X.c7.ocuklariniz.Devlet.okullarina.kayitli.degilse..farkli.t.fc.rdeki.okullara.gidiyor.muydu.", "If.the.individual.is.over.18..U.0096..Did.you.try.to.continue.your.higher.education.in.Turkey.",
     "What.was.the.reason.that.you.discontinued.your.education.in.Turkey.", "Why.have.you.not.take.steps.to.continue.your.higher.education.in.Turkey.", "Do.you.have.chronic.health.problems.", "Did.you.have.access.to.health.services.in.Turkey.",
     "X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.People.in.Turkey.are.hostile..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.unite.with.my.relatives.residing.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.have.any.work.opportunities.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.Exploitation.at.the.workplace..What.are.your.reasons.to.leave.Turkey.", "X.I.have.poor.quality.of.life.in.Turkey...What.are.your.reasons.to.leave.Turkey.", "X.I.feel.isolated.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.cannot.benefit.from.medical.services.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X..I.My.children.cannot.continue.education.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.have.security.problems.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.find.Turkish.culture.hard.to.adopt..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.find.myself.comfortable.in.terms.of.my.religious.convictions.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.The.language.is.difficult.for.me..What.are.your.reasons.to.leave.Turkey.", "X..I.want..or.my.children..to.continue.education.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.am.not.going.to.be.resettled.by.UNHCR..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.have.better.future.for.myself.and.my.children...What.are.your.reasons.to.leave.Turkey.",
     "X.It.is.too.close.to.Syria...What.are.your.reasons.to.leave.Turkey.", "X.Other..What.are.your.reasons.to.leave.Turkey.", "Have.you.tried.to.cross.to.Greece.before.", "How.many.times.did.you.attempt.to.cross.Greece.",
     "Do.you.plan.to.try.again.", "Have.you.ever.been.stopped.and.returned.to.Turkey.by.the.Greek.Coast.Guards", "What.are.your.future.plans..intentions.", "Which.country.is.your.final.destination.",
     "X.I.have.relatives.in.this.country..Why.do.you.want.to.go.to.this.country.", "X.I.know.that.they.will.financially.help.me.there......Why.do.you.want.to.go.to.this.country.", "X.I.can.work.there..Why.do.you.want.to.go.to.this.country.", "X.I.want.to.continue.my.education.there..Why.do.you.want.to.go.to.this.country.",
     "X.I.can.be.a.citizen.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.apply.for.asylum.there..Why.do.you.want.to.go.to.this.country.", "X.My.children.would.have.better.future..Why.do.you.want.to.go.to.this.country.", "Would.you.prefer.to.stay.in.Turkey.rather.than.going.to.another.country..if.you.had.the.chance.",
     "X.Employment..What.would.make.you.stay.in.Turkey.", "X.Education.opportunities..What.would.make.you.stay.in.Turkey.", "X.Material.support..What.would.make.you.stay.in.Turkey.", "X.Shelter.support..What.would.make.you.stay.in.Turkey.",
     "X.Unaccompanied.and.separated.child....Any.specific.needs.identified.", "X.Female.Head.of.Household..Any.specific.needs.identified.", "X.Medical.problems..Any.specific.needs.identified.", "X.Disabled...Any.specific.needs.identified.",
     "X.Victim.of.torture...Any.specific.needs.identified.", "X.Pregnant.woman...Any.specific.needs.identified.", "X.Elderly...Any.specific.needs.identified.", "Date.of.the.interview",
     "Name.of.the.Interviewer", "Location.of.the.Interview", "TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.")

crs$numeric <- c("X.It.is.too.costly.to.live.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.People.in.Turkey.are.hostile..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.unite.with.my.relatives.residing.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.have.any.work.opportunities.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.Exploitation.at.the.workplace..What.are.your.reasons.to.leave.Turkey.", "X.I.have.poor.quality.of.life.in.Turkey...What.are.your.reasons.to.leave.Turkey.", "X.I.feel.isolated.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.cannot.benefit.from.medical.services.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X..I.My.children.cannot.continue.education.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.have.security.problems.in.Turkey..What.are.your.reasons.to.leave.Turkey.", "X.I.find.Turkish.culture.hard.to.adopt..What.are.your.reasons.to.leave.Turkey.", "X.I.do.not.find.myself.comfortable.in.terms.of.my.religious.convictions.in.Turkey..What.are.your.reasons.to.leave.Turkey.",
     "X.The.language.is.difficult.for.me..What.are.your.reasons.to.leave.Turkey.", "X..I.want..or.my.children..to.continue.education.abroad..What.are.your.reasons.to.leave.Turkey.", "X.I.am.not.going.to.be.resettled.by.UNHCR..What.are.your.reasons.to.leave.Turkey.", "X.I.want.to.have.better.future.for.myself.and.my.children...What.are.your.reasons.to.leave.Turkey.",
     "X.It.is.too.close.to.Syria...What.are.your.reasons.to.leave.Turkey.", "X.Other..What.are.your.reasons.to.leave.Turkey.", "X.Employment..What.would.make.you.stay.in.Turkey.", "X.Education.opportunities..What.would.make.you.stay.in.Turkey.",
     "X.Material.support..What.would.make.you.stay.in.Turkey.", "X.Shelter.support..What.would.make.you.stay.in.Turkey.")

crs$categoric <- c("startlanguage", "Age.Group", "Sex", "Marital.Status",
     "Ethnicity", "Religion", "Education", "X.Comment..Education",
     "Number.of.children.in.the.family", "Family.Size", "X.Afghanistan...Country.of.Origin", "X.Iran...Country.of.Origin",
     "X.Iraq...Country.of.Origin", "X.Palestine...Country.of.Origin", "X.Pakistan...Country.of.Origin", "X.Sudan...Country.of.Origin",
     "X.Syria...Country.of.Origin", "Which.country.did.you.arrive.from.to.Turkey.", "X.Other....Which.country.did.you.arrive.from.to.Turkey.", "X.1.year.to.less.than.2.years....How.long.did.you.stay.in.that.country..U.00A0.",
     "X.2.years.to.less.than.3.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.3.years.to.less.than.5.years....How.long.did.you.stay.in.that.country..U.00A0.", "X.5.years.and.more....How.long.did.you.stay.in.that.country..U.00A0.", "Why.did.you.decide.to.come.to.Turkey.",
     "How.do.you.access.information.on.your.travel.route..asylum.procedures..means.of.travel..border.crossings..registration..access.to.services..procedures..etc.", "In.your.country.of.origin..did.you.use.to.work.", "X.Accountant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Architect.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Artist.sculptor.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Author.journalist.writer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Baker.pastry.cook.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Blacksmith.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Bricklayer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Builder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Driver.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Business.services.agent.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Carpenter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Clerk.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Cook.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Craftsman.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Electrical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronic.Telecommunications.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Electronics.mechanic.servicer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Farmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Farm.hand...laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Gardener.horticultural.grower.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.General.manager.own.or.small.business......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Glassmaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hairdresser.barber.beautician.and.related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.in.textile.leather...related.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Handicraft.worker.inwood...related.materials.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Helper.cleaner.in.offices..hotels.etc......Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Mechanical.engineer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.doctor.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Motor.vehicle.mechanic.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Nurse.midwifery.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Police.officer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Religious.professional.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Sales.representative.merchant.trader.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Salesperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.cleaning.other.street.service.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Shoe.maker.related.worker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Tailor.dressmaker.hatter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Teacher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Translator.interpreter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Veterinarian.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin",
     "X.Waiter.waitresses.bartender.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Welder.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Other....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "How.long.have.you.been.in.Turkey..U.00A0.....U.00A0.",
     "Are.you.registered.with.the.authorities.in.Turkey.", "X.Yes..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.don.U.0092.t.know.how.to.take.it..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.",
     "X.No..Because..I.applied.to.the.authorities..but.I.haven.U.0092.t.received.it.yet..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.No..Because.I.did.not.apply.to.Turkish.authorities...Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.Other..Do.you.have.foreigner.U.0092.s.ID.Number..an.11.digit.number.begins.with.99.or.98.", "X.1",
     "X.Other.", "Did.you.register.with.UNHCR.", "X.I.want.to.resettle.to.a.third.country.through.UNHCR..Why.did.you.register.with.UNHCR.", "X.I.heard.about.UNHCR.from.my.relatives.neighbors.other.compatriots.from.CoO.and.they.told.me.to.approach..Why.did.you.register.with.UNHCR.",
     "X.UNHCR.would.give.me.documentation..Why.did.you.register.with.UNHCR.", "X.I.want.to.move.to.Greece.and.the.documentation.will.help.me.to.travel...Why.did.you.register.with.UNHCR.", "X.I.don.U.0092.t.know.where.else.to.apply..Why.did.you.register.with.UNHCR.", "In.which.city.have.you.been.residing.in.Turkey.",
     "Have.you.stayed.in.the.camp.in.Turkey..U.00A0.", "Why.did.you.leave.the.camp.and.arrive.in.this.city.", "Do.you.have.any.relatives.left.behind.in.the.camp.or.in.the.city.where.you.used.to.reside.in.Turkey.", "In.Turkey..have.you.ever.worked.in.Turkey...PLEASE.TICK.ONLY.ONE.BOX.",
     "How.did.you.find.job.in.Turkey.", "Did.you.have.work.permit.", "Which.one.among.the.below.describes.your.situation.", "Do.you.have.problems.in.relation.to.your.working.conditions.",
     "X.The.working.hours.are.too.long.when.compared.to.my.salary..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.my.employer.supervisor...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior..by.other.employee.s....Please.explain.in.the.box.below...I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.cannot.get.my.salary.in.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.cannot.get.my.salary..in.the.amount.we.agreed.on..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.salary.does.not.reflect.the.hardship.of.my.job..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.work.longer.than.we.agreed.on..but.cannot.get.extra.money.for.the.extra.time..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.My.employer.supervisor.wants.me.to.fulfill.duties.that.are.not.included.in.my.work.definition..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.",
     "X.I.face.rude.expressions..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.I.face.annoying.behavior.by.locals.because.I.am.working..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "X.Other..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.",
     "X.Comment..Are.your.children..between.6.and.18..officially.registered.to.primary.secondary.high.state.school.in.Turkey..Please.tick.the.box.es..that.suits.best.to.the.individual.U.0092.s.children.U.0092.s.case..U.00A0.If.Not.registered.and.not.attending.school.pleasing.explain.why.", "If.your.children.are.not.registered.in.Turkish.State.schools..do.they.go.to.any.different.type.of.school..U.00A0.Please.explain..U.00A0.", "X.c7.ocuklariniz.Devlet.okullarina.kayitli.degilse..farkli.t.fc.rdeki.okullara.gidiyor.muydu.", "If.the.individual.is.over.18..U.0096..Did.you.try.to.continue.your.higher.education.in.Turkey.",
     "What.was.the.reason.that.you.discontinued.your.education.in.Turkey.", "Why.have.you.not.take.steps.to.continue.your.higher.education.in.Turkey.", "Do.you.have.chronic.health.problems.", "Did.you.have.access.to.health.services.in.Turkey.",
     "Have.you.tried.to.cross.to.Greece.before.", "How.many.times.did.you.attempt.to.cross.Greece.", "Do.you.plan.to.try.again.", "Have.you.ever.been.stopped.and.returned.to.Turkey.by.the.Greek.Coast.Guards",
     "What.are.your.future.plans..intentions.", "Which.country.is.your.final.destination.", "X.I.have.relatives.in.this.country..Why.do.you.want.to.go.to.this.country.", "X.I.know.that.they.will.financially.help.me.there......Why.do.you.want.to.go.to.this.country.",
     "X.I.can.work.there..Why.do.you.want.to.go.to.this.country.", "X.I.want.to.continue.my.education.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.be.a.citizen.there..Why.do.you.want.to.go.to.this.country.", "X.I.can.apply.for.asylum.there..Why.do.you.want.to.go.to.this.country.",
     "X.My.children.would.have.better.future..Why.do.you.want.to.go.to.this.country.", "Would.you.prefer.to.stay.in.Turkey.rather.than.going.to.another.country..if.you.had.the.chance.", "X.Unaccompanied.and.separated.child....Any.specific.needs.identified.", "X.Female.Head.of.Household..Any.specific.needs.identified.",
     "X.Medical.problems..Any.specific.needs.identified.", "X.Disabled...Any.specific.needs.identified.", "X.Victim.of.torture...Any.specific.needs.identified.", "X.Pregnant.woman...Any.specific.needs.identified.",
     "X.Elderly...Any.specific.needs.identified.", "Date.of.the.interview", "Name.of.the.Interviewer", "Location.of.the.Interview",
     "TJN_X.1...30days....How.long.did.you.stay.in.that.country..U.00A0._X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.")

crs$target  <- NULL
crs$risk    <- NULL
crs$ident   <- "submitdate"
crs$ignore  <- c("X", "id", "token", "X.Azerbaijan...Country.of.Origin", "X.Cameroon...Country.of.Origin", "X.China...Country.of.Origin", "X.Congo...Country.of.Origin", "X.Cote.D.U.0092.Ivoire...Country.of.Origin", "X.Dem..Rep..of.Congo...Country.of.Origin", "X.Eritrea...Country.of.Origin", "X.Ethiopia...Country.of.Origin", "X.Uzbekistan...Country.of.Origin", "X.Kyrgyzstan...Country.of.Origin", "X.Liberia...Country.of.Origin", "X.Mauritania...Country.of.Origin", "X.Myanmar...Country.of.Origin", "X.Sierra.Leone...Country.of.Origin", "X.Somali...Country.of.Origin", "X.Sri.Lanka...Country.of.Origin", "X.Other..Country.of.Origin", "X.1...30days....How.long.did.you.stay.in.that.country..U.00A0.", "X.1.month.to.less.than.1.year....How.long.did.you.stay.in.that.country..U.00A0.", "X.Aircraft.pilot.related.professionals.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Building.caretaker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Butcher.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Computer.equipment.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Computer.programmer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Dairy.producer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Dentist.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Domestic.helper.cleaner.Housekeeper.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Doorkeeper.watchperson.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Garbage.collector.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Hunter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Jewel.maker.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Judge.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Market.orientedanimal.producer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Medical.assistant.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Photographer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Production.operationsdepartment.manager.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Radio.TV.related.announcer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Safety.quality.inspectors.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Secretary.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Senior.official.of.political.party.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sewing.machine.operator.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Ships.U.0092..deck.crew.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Statistician.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Sweeper.related.laborer.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.University.teaching.staff.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Vehicle.window.related.cleaners.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.Weaver.knitter.....Please.tick.the.job.that.applies.to.the.foreigners.in.his..her.country.of.origin", "X.My.employer.holds.my.legal.documents.and.does.not.give.them.back..I.have.following.problems.related.to.my.working.conditions.in.Turkey..Please.tick.as.many.boxes.as.applies.to.your.case.", "Please.Explain", "X.LGBTi..Any.specific.needs.identified.")
crs$weights <- NULL

#============================================================
# Rattle timestamp: 2016-01-16 18:15:13 x86_64-w64-mingw32 

# Generate a correlation plot for the variables. 

# The 'corrplot' package provides the 'corrplot' function.

library(corrplot, quietly=TRUE)

# Correlations work for numeric variables only.

crs$cor <- cor(crs$dataset[crs$sample, crs$numeric], use="pairwise", method="pearson")

# Order the correlations by their strength.

crs$ord <- order(crs$cor[1,])
crs$cor <- crs$cor[crs$ord, crs$ord]

# Display the actual correlations.

print(crs$cor)

# Graphically display the correlations.

corrplot(crs$cor, mar=c(0,0,1,0))
title(main="Correlation data.csv using Pearson",
    sub=paste("Rattle", format(Sys.time(), "%Y-%b-%d %H:%M:%S"), Sys.info()["user"]))
