#
#  This file is part of the `BraDiPluS` R package
#
#  Copyright (c) 2016 EMBL-EBI
#
#  File author(s): Federica Eduati (federica.eduati@gmail.com)
#
#  Distributed under the GPLv3 License.
#  See accompanying file LICENSE.txt or copy at
#      http://www.gnu.org/licenses/gpl-3.0.html
#
#  Website: https://github.com/saezlab/BraDiPluS
# --------------------------------------------------------
#
#' Select fluorescence peaks for each sample.
#' 
#' \code{selectSamplesPeaks} allows to select peaks for all samples.
#' 
#' This function select the peaks for all the samples previously identified using \code{\link{samplesSelection}} by applying the function
#' \code{\link{peaksSelection}} to the data corresponding to the different samples.
#' 
#' @param samples samples as output of the function \code{\link{samplesSelection}}
#' @param channel channel to be considered, default="green"
#' @param metric metric to be used, selct among "median", "mean", "max" or "AUC", default is median
#' @param Nchannel channel to be used to normalise data, default is NA (use not recommended)
#' @param baseThr threshold on the baseline used in order to define what is a peak, default is 0.01
#' @param minLength minimum length of a plug/droplet in number of data points, default is 10 (note that unit is
#' number of data points, not seconds)
#' @param discartPeaks select of to discart first and/or last peak ("first" discart the first, "last" discart the last,
#' "both" discart both), default is NA
#' @param discartPeaksPerc select the percentage of peaks to discart if discartPeaks is defined. Default is 1
#' @return This function returns a list with, in each positions peaks for the corrsponding samples. Peaks are organized as data.frame
#' with one peak for each row and 9 columns:
#' \describe{
#'   \item{green}{value of the peak in the green channel}
#'   \item{orange}{value of the peak in the orange channel}
#'   \item{blue}{value of the peak in the blue channel}
#'   \item{norm}{value of the selected channel normalized by the value of the Nchannel, if the Nchannel is provided (otherwise the value is set to 0)}
#'   \item{start}{starting point of the peak}
#'   \item{end}{final point of the peak}
#'   \item{length}{length of the peak}
#' }
#' @seealso \code{\link{samplesSelection}}
#' @examples 
#' data(BxPC3_data,package="BraDiPluS")
#' res <- samplesSelection(data=MyData, BCchannel="blue", 
#' BCthr=0.01, distThr=300, plotMyData=TRUE)
#' samples <-res$samples
#' samplesPeaks <- selectSamplesPeaks(samples, channel="green", metric="median", baseThr=0.01, minLength=350, discartPeaks="first", discartPeaksPerc=5)
#' @export
 
selectSamplesPeaks <- function(samples, channel="green", metric="median", Nchannel=NA, baseThr=0.01, minLength=10, discartPeaks=NA, discartPeaksPerc=1){
  
  peaksALLsamples <- lapply(samples, peaksSelection, channel=channel, metric=metric, Nchannel=Nchannel, baseThr=baseThr, minLength=minLength, discartPeaks=discartPeaks, discartPeaksPerc= discartPeaksPerc)

	return(peaksALLsamples)    
}
