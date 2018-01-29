#' Add Labels to DETECT Screening Questions
#'
#' Use this function to add value labels (question text) to DETECT pilot test
#'  screening questions.
#'
#' @return A character vector with length 78
#' @export
#'
#' @examples
#' # qsummary$question  <- label_qtext()
label_qtext <- function(){
  qtext <- c(
    "sdq36" = "Unusual odor (e.g. urine, feces)",
    "sdq37" = "One or more utilities are not operational (no water electric, heating/cooling)",
    "sdq38" = "Inside of the home is in extreme disarray / hoarding",
    "sdq39" = "Living environment poses a health or safety concern (e.g. fire hazard, insect or rodent infestation, urine or feces present)",
    "sdq40" = "Open alcohol containers or other alcohol/drug paraphernalia present",
    "sdq41" = "To lack knowledge of the patient/older adult's medical need(s)",
    "sdq42" = "Unengaged and inattentive in caring for the patient/older adult",
    "sdq43" = "Overwhelmed by the patient / older adult",
    "sdq44" = "Frustrated, tired, angry, or burdened by the patient/older adult",
    "sdq45" = "Overly concerned (e.g. anxious, hovering)",
    "sdq46" = "To be deceptive or withhold information from you",
    "sdq47" = "To give you information that is inconsistent with the patient / older adult's account",
    "sdq48" = "To be under the influence of alcohol and/or illicit drugs",
    "sdq49" = "To be dependent on the patient / older adult for financial or other needs",
    "sdq50" = "Does the patient / older adult appear to lack social support or family that cares for them?",
    "sdq51" = "Does the patient / older adult hesitate to talk with you or discuss their condition in front of the caregiver?",
    "sdq52" = "Isolated in the home",
    "sdq53" = "Have suspicious falls, wounds, and/or injuries",
    "sdq54" = "Show evidence of any old injuries that have been left untreated",
    "sdq55" = "Under the influence of alcohol and/or illicit drugs",
    "sdq56" = "Appear depressed, anxious, or emotionally distressed for reasons other than their immediate medical condition",
    "sdq57" = "Have poor personal hygiene (including soiled in urine or feces)",
    "sdq58" = "Inadequately clothed or wearing dirty, torn, or soiled clothing",
    "sdq59" = "Have difficulties taking their prescribed medications as directed",
    "sdq60" = "Appear to be hoarding/saving old medications",
    "sdq61" = "Need assistance with eating, toileting, transferring, dressing, or bathing"
  )
  return(qtext)
}